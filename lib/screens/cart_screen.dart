import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final textStyle = TextStyle(
            color: Colors.blue,
            fontSize: isTablet ? 20 : 16,
          );
          final iconSize = isTablet ? 80.0 : 50.0;

          return cart.products.isEmpty
              ? Center(child: Text('Tu carrito está vacío', style: textStyle))
              : ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (context, index) {
                    final product = cart.products[index];
                    return ListTile(
                      leading: Image.asset(product.image, width: iconSize),
                      title: Text(product.name, style: textStyle),
                      subtitle: Text('\$${product.price.toStringAsFixed(0)}', style: textStyle),
                      trailing: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          foregroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          cart.remove(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Producto eliminado del carrito!')),
                          );
                        },
                        child: const Text('Eliminar'),
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth > 600;
                final textSize = isTablet ? 24.0 : 20.0;
                return Text(
                  'Total: \$${cart.totalPrice.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentScreen()),
                );
              },
              child: const Text('Pagar'),
            ),
          ],
        ),
      ),
    );
  }
}
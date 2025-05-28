import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Product(
      name: title,
      price: double.tryParse(price) ?? 0.0,
      image: imageUrl,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 50,
                height: 50,
                color: Colors.grey[200],
                child: const Icon(Icons.bakery_dining, color: Colors.grey),
              );
            },
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        subtitle: Text('\$$price', style: const TextStyle(color: Colors.blue)),
        trailing: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            foregroundColor: Colors.blue,
          ),
          child: const Text('Agregar'),
          onPressed: () {
            Provider.of<CartModel>(context, listen: false).add(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title agregado al carrito')),
            );
          },
        ),
      ),
    );
  }
}
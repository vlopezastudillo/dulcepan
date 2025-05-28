import 'package:flutter/material.dart';
import 'package:dulcepan/screens/orders_screen.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  String selectedPaymentMethod = '';
  final _cardNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _cardExpiryController = TextEditingController();
  final _cardCvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Pago', style: TextStyle(color: Colors.blue)),
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Método de pago', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedPaymentMethod = 'Apple Pay';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text('Apple Pay'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedPaymentMethod = 'Tarjeta de crédito';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text('Tarjeta de crédito'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (selectedPaymentMethod == 'Tarjeta de crédito') ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Número de tarjeta', style: TextStyle(color: Colors.black54)),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        validator: (value) {
                          if (value == null || value.replaceAll(' ', '').length < 16) {
                            return 'Número de tarjeta inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Fecha de vencimiento', style: TextStyle(color: Colors.black54)),
                                const SizedBox(height: 4),
                                TextFormField(
                                  controller: _cardExpiryController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    hintText: 'MM/YY',
                                  ),
                                  validator: (value) {
                                    if (value == null || !RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
                                      return 'Fecha inválida';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('CVV', style: TextStyle(color: Colors.black54)),
                                const SizedBox(height: 4),
                                TextFormField(
                                  controller: _cardCvvController,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    hintText: 'XXX',
                                  ),
                                  validator: (value) {
                                    if (value == null || !RegExp(r'^\d{3}$').hasMatch(value)) {
                                      return 'CVV inválido';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Nombre del titular', style: TextStyle(color: Colors.black54)),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _cardNameController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Nombre completo',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nombre no puede estar vacío';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (selectedPaymentMethod == 'Apple Pay') ...[
              const Text('Usando Apple Pay para completar tu compra.', style: TextStyle(color: Colors.blue)),
            ],
            const Spacer(),
            const Text('Total: \$14.990', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                if (selectedPaymentMethod == 'Tarjeta de crédito') {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Pago realizado exitosamente!')),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ConfirmationScreen()),
                  );
                });
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Text('Pagar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation.dart';
import 'models/cart_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: const DulcePanApp(),
    ),
  );
}

class DulcePanApp extends StatelessWidget {
  const DulcePanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dulce Pan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.blue),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue, // texto azul
            backgroundColor: Colors.transparent, // fondo transparente
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.blue), // borde azul
            ),
          ),
        ),
      ),
      home: const LoginScreen(), // Inicia en la pantalla de login
      debugShowCheckedModeBanner: false,
    );
  }
}
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final avatarRadius = isTablet ? 80.0 : 60.0;
          final nameFontSize = isTablet ? 28.0 : 22.0;
          final emailFontSize = isTablet ? 20.0 : 16.0;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: const AssetImage('assets/images/perfil.jpg'),
                    backgroundColor: Colors.blue,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Usuario de Dulce Pan',
                    style: TextStyle(
                      fontSize: nameFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'usuario@dulcepan.cl',
                    style: TextStyle(fontSize: emailFontSize, color: Colors.blue),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('¡Funcionalidad próximamente!')),
                        );
                      },
                      child: const Text(
                        'Editar Perfil',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
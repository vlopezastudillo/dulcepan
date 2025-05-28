import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {
        'title': 'Orden #001',
        'description': 'Croissant x2, Torta Imperial x1',
        'date': '26 mayo 2025'
      },
      {
        'title': 'Orden #002',
        'description': 'Pan de Pascua x3',
        'date': '25 mayo 2025'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Órdenes Realizadas', style: TextStyle(color: Colors.blue)),
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final textStyle = TextStyle(
            color: Colors.blue,
            fontSize: isTablet ? 18 : 14,
          );

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const Divider(color: Colors.blue, thickness: 0.5),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    order['title']!,
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${order['description']} - ${order['date']}',
                    style: textStyle,
                  ),
                  trailing: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      foregroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('¡Próximamente podrás ver el detalle de tu orden!')),
                      );
                    },
                    child: const Text('Ver'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
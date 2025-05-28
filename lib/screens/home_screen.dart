import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;
  int _currentPage = 0;

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    // Start auto-scrolling timer
    _startAutoScroll();
    _filteredProducts = products;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  final List<String> carouselImages = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  final List<Map<String, String>> products = [
    {
      'title': 'Croissant',
      'description': 'Croissant dorado, hojaldrado y recién horneado',
      'image': 'assets/images/croissant.jpg'
    },
    {
      'title': 'Torta Imperial',
      'description': 'Torta artesanal, suave y rellena de dulce tradición en cada capa',
      'image': 'assets/images/torta_imperial.jpg'
    },
    {
      'title': 'Pan Artesanal',
      'description': 'Hecho con masa madre, corteza crujiente y miga aireada',
      'image': 'assets/images/pan_artesanal.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Dulce Pan', style: TextStyle(color: Colors.blue)),
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrusel
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                itemCount: carouselImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        carouselImages[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Page indicator
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                carouselImages.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.blue.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sección Hot Sale
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hot Sale',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Buscar producto...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _filteredProducts = products
                        .where((product) => product['title']!.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),

            // Cards de productos responsivos
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 2;
                if (constraints.maxWidth > 600) {
                  crossAxisCount = 3;
                }
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.asset(
                                product['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                            child: Text(
                              product['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product['description']!,
                              style: const TextStyle(fontSize: 11, color: Colors.black54),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                final productToAdd = Product(
                                  name: product['title']!,
                                  price: 2990,
                                  image: product['image']!,
                                );
                                Provider.of<CartModel>(context, listen: false).add(productToAdd);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${product['title']} agregado al carrito!')),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                side: const BorderSide(color: Colors.blue),
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                minimumSize: const Size(80, 30),
                              ),
                              child: const Text('Agregar', style: TextStyle(fontSize: 11)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
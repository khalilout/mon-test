import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ProductPublicScreen extends StatelessWidget {
  const ProductPublicScreen({super.key});

  Future<List<Product>> fetchPublicProducts(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    return await authService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produits disponibles"),
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            tooltip: 'Se connecter',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchPublicProducts(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(child: Text('Aucun produit trouvé.'));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    /*child: Image.network(
                      p.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    ),*/
                  ),
                  title: Text(p.name, overflow: TextOverflow.ellipsis),
                  subtitle: Text(
                    '${p.price} MRU\n${p.description}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

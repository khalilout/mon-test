import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../services/auth_service.dart';
import 'product_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  String selectedFilter = 'Nom';
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMore();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    if (isLoadingMore || !hasMore) return;

    setState(() => isLoadingMore = true);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (authService.token == null) {
      debugPrint('Token null. Impossible de charger les produits.');
      setState(() => isLoadingMore = false);
      return;
    }

    try {
      final newProducts = await authService.fetchProducts(page: currentPage);
      if (!mounted) return;

      setState(() {
        products.addAll(newProducts);
        currentPage++;
        if (newProducts.length < 10) hasMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement : $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() => isLoadingMore = false);
    }
  }

  Future<void> _createProduct(String name, String price, String description) async {
    final token = Provider.of<AuthService>(context, listen: false).token;
    if (token == null) return;

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/articles'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'nom': name,
          'prix': price,
          'description': description,
          'quantite': '1',
        },
      );
      debugPrint('CREATE: ${response.statusCode} - ${response.body}');
    } catch (e) {
      debugPrint('Erreur lors de la création : $e');
    }
  }

  Future<void> _editProduct(int id, String name, String price, String description) async {
    final token = Provider.of<AuthService>(context, listen: false).token;
    if (token == null) return;

    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/articles/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'nom': name,
          'prix': price,
          'description': description,
          'quantite': '1',
        },
      );
      debugPrint('EDIT: ${response.statusCode} - ${response.body}');
    } catch (e) {
      debugPrint('Erreur lors de la modification : $e');
    }
  }

  Future<void> _removeProduct(int id) async {
    final token = Provider.of<AuthService>(context, listen: false).token;
    if (token == null) return;

    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/articles/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      debugPrint('DELETE: ${response.statusCode}');
    } catch (e) {
      debugPrint('Erreur lors de la suppression : $e');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onFilterChanged(String? newValue) {
    if (newValue == null) return;
    setState(() {
      selectedFilter = newValue;
      products.clear();
      currentPage = 1;
      hasMore = true;
    });
    _loadMore();
  }

  void _onAddProduct() {
    showDialog(
      context: context,
      builder: (context) => ProductForm(
        onSubmit: (name, price, description) async {
          Navigator.pop(context);
          await _createProduct(name, price, description);
          setState(() {
            products.clear();
            currentPage = 1;
            hasMore = true;
          });
          _loadMore();
        },
      ),
    );
  }

  void _onEditProduct(Product product) {
    showDialog(
      context: context,
      builder: (context) => ProductForm(
        product: product,
        onSubmit: (name, price, description) async {
          Navigator.pop(context);
          await _editProduct(product.id, name, price, description);
          setState(() {
            products.clear();
            currentPage = 1;
            hasMore = true;
          });
          _loadMore();
        },
      ),
    );
  }

  void _onDeleteProduct(int id) async {
    await _removeProduct(id);
    setState(() {
      products.clear();
      currentPage = 1;
      hasMore = true;
    });
    _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue ${user?.name ?? ''}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _onAddProduct,
          ),
          TextButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text("Déconnexion"),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).logout();
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            /*child: DropdownButton<String>(
              value: selectedFilter,
              items: ['Nom', 'Prix', 'Catégorie'].map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: _onFilterChanged,
            ),*/
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: products.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < products.length) {
                  final p = products[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      /*leading: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: p.imageUrl.isNotEmpty
                          ? p.imageUrl
                          : 'http://10.0.2.2:8000/storage/default.png',

                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),*/
                      title: Text(p.name),
                      subtitle: Text('${p.price} MRU\n${p.description}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _onEditProduct(p),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _onDeleteProduct(p.id),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
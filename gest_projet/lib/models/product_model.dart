class Product {
  final int id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['nom'] ?? 'Nom inconnu',
      price: json['prix']?.toString() ?? '0',
      description: json['description'] ?? 'description Inconnue',
      imageUrl: json['image'] != null
          ? 'http://10.0.2.2:8000/storage/${json['image']}'
          : 'https://via.placeholder.com/150',
    );
  }
}

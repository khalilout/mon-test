import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/app_user.dart';
import 'package:gest_projet/models/app_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gest_projet/models/product_model.dart';


class AuthService extends ChangeNotifier {
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  bool isLoading = false;
  bool isAuthenticated = false;
  String? error;
  String? token;
  AppUser? user;

  // Connexion
  Future<bool> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  token = data['access_token']; // <- CORRIGÉ ICI
  isAuthenticated = true;
  
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token!);
  notifyListeners();
  user = AppUser.fromJson(data['user']);
  print(response.body); 

  return true;
}
 else {
        final data = jsonDecode(response.body);
        error = data['message'] ?? 'Erreur inconnue';
        return false;
      }
    } catch (e) {
      error = 'Erreur de connexion';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Inscription
  Future<bool> register(String name, String email, String password, String confirmPassword) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Accept': 'application/json'},
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final data = jsonDecode(response.body);
        if (data['errors'] != null) {
          error = data['errors'].values.first[0];
        } else {
          error = data['message'] ?? 'Erreur inconnue';
        }
        return false;
      }
    } catch (e) {
      error = 'Erreur de connexion';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Déconnexion
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    isAuthenticated = false;
    token = null;
    user = null;
    notifyListeners();
  }

  // Récupération du profil utilisateur
  Future<void> getUserProfile() async {
  isLoading = true;
  notifyListeners();

  final prefs = await SharedPreferences.getInstance();
  final storedToken = prefs.getString('token');
  if (storedToken != null) {
    token = storedToken;
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user = AppUser.fromJson(data);
        isAuthenticated = true;
      } else {
        user = null;
        isAuthenticated = false;
      }
    } catch (e) {
      user = null;
      isAuthenticated = false;
    }
  }
  
  isLoading = false;
  notifyListeners();
}

void clearError() {
  error = null;
  notifyListeners();
}




Future<List<Product>> fetchProducts({int page = 1}) async {
  final response = await http.get(
    Uri.parse('$_baseUrl/articles?page=$page'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    print(jsonData); // 👈 Ajoute ça pour voir la structure
    final List data = jsonData['data'];
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Erreur lors de la récupération des produits');
  }
}






/*Future<bool> storeProduct(String name, String price, String description) async {
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

    debugPrint('Store response: ${response.statusCode} → ${response.body}');
    return response.statusCode == 201;
  } catch (e) {
    debugPrint('Erreur storeProduct: $e');
    return false;
  }
}*/

Future<bool> storeProduct(String name, String price, String description) async {
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
    debugPrint('Store response: ${response.statusCode} → ${response.body}');
    return response.statusCode == 201;
  } catch (e) {
    debugPrint('Erreur storeProduct: $e');
    return false;
  }
}

Future<bool> updateProduct(int id, String name, String price, String description) async {
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
    debugPrint('Update response: ${response.statusCode} → ${response.body}');
    return response.statusCode == 200;
  } catch (e) {
    debugPrint('Erreur updateProduct: $e');
    return false;
  }
}

Future<bool> deleteProduct(int id) async {
  try {
    final response = await http.delete(
      Uri.parse('$_baseUrl/articles/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    debugPrint('Delete response: ${response.statusCode} → ${response.body}');
    return response.statusCode == 200 || response.statusCode == 204;
  } catch (e) {
    debugPrint('Erreur deleteProduct: $e');
    return false;
  }
}














}

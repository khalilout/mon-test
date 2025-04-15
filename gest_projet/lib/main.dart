import 'package:flutter/material.dart';
import 'package:gest_projet/Screens/ProductPublicScreen.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/product_public_screen.dart';
import 'screens/product_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService()..getUserProfile(), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: authService.isAuthenticated
              ? const ProductScreen()
              : const ProductPublicScreen(),
        );
      },
    );
  }
}

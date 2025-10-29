import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/presentation/pages/login_page.dart'; // New import path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PromoLink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Use the new LoginPage
    );
  }
}

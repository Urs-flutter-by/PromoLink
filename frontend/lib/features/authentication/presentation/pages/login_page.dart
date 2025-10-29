import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showLoginModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Вход для менеджеров'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Логин',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement login logic
                print('Логин: ${_usernameController.text}, Пароль: ${_passwordController.text}');
                Navigator.of(context).pop();
              },
              child: const Text('Войти'),
            ),
          ],
        );
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Fixed Left Sidebar
          Container(
            width: MediaQuery.of(context).size.width * 0.2, // 20% width
            color: const Color(0xFF1f619e), // primary color from template
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'НТС',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                // Login Button
                ElevatedButton(
                  onPressed: () => _showLoginModal(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // bg-white
                    foregroundColor: const Color(0xFF1f619e), // text-primary
                    minimumSize: const Size(double.infinity, 40), // w-full, h-10
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // rounded-lg
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.015, // tracking-[0.015em]
                    ),
                  ),
                  child: const Text('Вход для менеджеров'),
                ),
              ],
            ),
          ),
          // Main Content Area
          Expanded(
            child: Container(
              color: Colors.white, // bg-white
              child: const Center(
                child: Text(
                  'Main Content Area (Placeholder)',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

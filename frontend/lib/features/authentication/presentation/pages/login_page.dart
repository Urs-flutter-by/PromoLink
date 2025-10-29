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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600; // Define a breakpoint for mobile

    return Scaffold(
      body: isMobile
          ? Column( // Mobile layout
              children: [
                // Top Bar (replaces left sidebar for mobile)
                Container(
                  height: MediaQuery.of(context).size.height * 0.1, // Approx 1/8th height
                  color: const Color(0xFF1f619e), // primary color
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/logo.png', height: 40), // Logo
                      ElevatedButton(
                        onPressed: () => _showLoginModal(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1f619e),
                          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Вход для менеджеров'),
                      ),
                    ],
                  ),
                ),
                // Main Content Area for Mobile
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Проверьте свою акционную карту',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 192, // w-48
                          height: 192, // h-48
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 2), // Changed to solid, as dashed is not available
                            borderRadius: BorderRadius.circular(12.0), // rounded-lg
                          ),
                          child: const Icon(Icons.qr_code_scanner, size: 64, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Наведите QR-код на камеру',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        // Placeholder for Card Information
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1f619e), // bg-primary
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Информация о карте',
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              _buildCardInfoRow('Номер карты', '1234-5678-9012-3456'),
                              _buildCardInfoRow('Кем предоставлена', 'ОДО "Южный парк"'),
                              _buildCardInfoRow('Дата выдачи', '15 сентября 2025'),
                              _buildCardInfoRow('Приобретенное оборудование', 'ККМ Меркурий 185Ф'),
                              _buildCardInfoRow('Срок действия', '15 февраля 2026'),
                              _buildCardInfoRow('Скидка', 'скидка 10% на технику ОАО "АсторТрейд"'),
                              _buildCardStatusRow('Статус', 'Valid', Colors.green),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Row( // Desktop layout
              children: [
                // Fixed Left Sidebar
                Container(
                  width: screenWidth * 0.2, // 20% width
                  color: const Color(0xFF1f619e), // primary color from template
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset('assets/images/logo.png', height: 40),
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
                // Main Content Area for Desktop
                Expanded(
                  child: Container(
                    color: Colors.white, // bg-white
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Проверьте свою акционную карту',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Container(
                              width: 192, // w-48
                              height: 192, // h-48
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 2),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Icon(Icons.qr_code_scanner, size: 64, color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Наведите QR-код на камеру',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            // Placeholder for Card Information
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1f619e),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Информация о карте',
                                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCardInfoRow('Номер карты', '1234-5678-9012-3456'),
                                  _buildCardInfoRow('Кем предоставлена', 'ОДО "Южный парк"'),
                                  _buildCardInfoRow('Дата выдачи', '15 сентября 2025'),
                                  _buildCardInfoRow('Приобретенное оборудование', 'ККМ Меркурий 185Ф'),
                                  _buildCardInfoRow('Срок действия', '15 февраля 2026'),
                                  _buildCardInfoRow('Скидка', 'скидка 10% на технику ОАО "АсторТрейд"'),
                                  _buildCardStatusRow('Статус', 'Valid', Colors.green),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCardInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildCardStatusRow(String label, String statusText, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              statusText,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

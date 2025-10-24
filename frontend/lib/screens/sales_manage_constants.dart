import 'package:flutter/material.dart';

class SalesManageConstantsScreen extends StatefulWidget {
  const SalesManageConstantsScreen({super.key});

  @override
  State<SalesManageConstantsScreen> createState() => _SalesManageConstantsScreenState();
}

class _SalesManageConstantsScreenState extends State<SalesManageConstantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Constants'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to manage products screen
                print('Manage Products');
              },
              child: const Text('Manage Products'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to manage discounts screen
                print('Manage Discounts');
              },
              child: const Text('Manage Discounts'),
            ),
          ],
        ),
      ),
    );
  }
}

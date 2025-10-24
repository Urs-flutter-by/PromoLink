import 'package:flutter/material.dart';

class CtoManageDiscountsScreen extends StatefulWidget {
  const CtoManageDiscountsScreen({super.key});

  @override
  State<CtoManageDiscountsScreen> createState() => _CtoManageDiscountsScreenState();
}

class _CtoManageDiscountsScreenState extends State<CtoManageDiscountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Service Discounts'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('List of issued cards (similar to sales manager view)'),
            // TODO: Implement list of promo cards with search/filter
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement logic to set service discount for a selected card
                print('Set Service Discount');
              },
              child: const Text('Set Service Discount'),
            ),
          ],
        ),
      ),
    );
  }
}

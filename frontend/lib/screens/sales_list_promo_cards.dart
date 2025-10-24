import 'package:flutter/material.dart';

class SalesListPromoCardsScreen extends StatefulWidget {
  const SalesListPromoCardsScreen({super.key});

  @override
  State<SalesListPromoCardsScreen> createState() => _SalesListPromoCardsScreenState();
}

class _SalesListPromoCardsScreenState extends State<SalesListPromoCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issued Promo Cards'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // TODO: Implement search logic
                print('Search: $value');
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // TODO: Replace with actual data
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text('Promo Card ${index + 1}'),
                    subtitle: const Text('QR: ABC123, Client: XYZ Corp, Product: Widget'),
                    trailing: const Text('Status: Valid'),
                    onTap: () {
                      // TODO: Navigate to promo card details
                      print('Tapped on card ${index + 1}');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

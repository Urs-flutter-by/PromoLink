import 'package:flutter/material.dart';

class SalesLinkPromoCardScreen extends StatefulWidget {
  const SalesLinkPromoCardScreen({super.key});

  @override
  State<SalesLinkPromoCardScreen> createState() => _SalesLinkPromoCardScreenState();
}

class _SalesLinkPromoCardScreenState extends State<SalesLinkPromoCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String _qrSerial = '';
  String _unp = '';
  int _productId = 0; // Placeholder
  DateTime _validFrom = DateTime.now();
  DateTime _validUntil = DateTime.now().add(const Duration(days: 365));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Promo Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'QR Serial'),
                onChanged: (value) => _qrSerial = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter QR Serial';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Client UNP'),
                onChanged: (value) => _unp = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Client UNP';
                  }
                  return null;
                },
              ),
              // TODO: Implement product selection (dropdown/picker)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product ID'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _productId = int.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid Product ID';
                  }
                  return null;
                },
              ),
              // TODO: Implement date pickers for validFrom and validUntil
              Text('Valid From: ${_validFrom.toLocal().toIso8601String().split('T')[0]}'),
              Text('Valid Until: ${_validUntil.toLocal().toIso8601String().split('T')[0]}'),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement API call to link promo card
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    print('Linking promo card: QR: $_qrSerial, UNP: $_unp, Product ID: $_productId');
                  }
                },
                child: const Text('Link Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

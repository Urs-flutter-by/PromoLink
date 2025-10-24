import 'package:flutter/material.dart';

class SalesRedeemPromoCardScreen extends StatefulWidget {
  const SalesRedeemPromoCardScreen({super.key});

  @override
  State<SalesRedeemPromoCardScreen> createState() =>
      _SalesRedeemPromoCardScreenState();
}

class _SalesRedeemPromoCardScreenState
    extends State<SalesRedeemPromoCardScreen> {
  String? _qrCode; // This would come from a QR scanner

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redeem Promo Card')),
      body: Center(
        child: _qrCode == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Scan QR Code to redeem promo card'),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement QR scanning logic
                      setState(() {
                        _qrCode = 'sample_qr_456'; // Simulate a scanned QR code
                      });
                    },
                    child: const Text('Scan QR Code'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('QR Code: $_qrCode'),
                  Text('Displaying details for $_qrCode'),
                  // TODO: Fetch and display actual promo card details
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement API call to redeem promo card
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Redeeming Card')),
                      );
                      print('Redeeming promo card: QR: $_qrCode');
                    },
                    child: const Text('Redeem Card'),
                  ),
                ],
              ),
      ),
    );
  }
}

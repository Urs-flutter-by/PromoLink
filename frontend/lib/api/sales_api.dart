import 'package:dio/dio.dart';

class SalesApi {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/')); // TODO: Get base URL from config

  Future<Map<String, dynamic>> createPromoCard({
    required String qrSerial,
    required String unp,
    required int productId,
    required DateTime validFrom,
    required DateTime validUntil,
  }) async {
    try {
      final response = await _dio.post(
        '/promo-cards',
        data: {
          'qr_serial': qrSerial,
          'unp': unp,
          'product_id': productId,
          'valid_from': validFrom.toIso8601String().split('T')[0],
          'valid_until': validUntil.toIso8601String().split('T')[0],
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Failed to create promo card: ${e.response?.data}');
      } else {
        throw Exception('Failed to connect to the server: ${e.message}');
      }
    }
  }

  // TODO: Implement UNP lookup if needed on the frontend
}

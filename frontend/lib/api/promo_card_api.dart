import 'package:dio/dio.dart';

class PromoCardApi {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/')); // TODO: Get base URL from config

  Future<Map<String, dynamic>> getPromoCardDetails(String qrSerial) async {
    try {
      final response = await _dio.get('/promo-cards/$qrSerial');
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Failed to load promo card details: ${e.response?.data}');
      } else {
        throw Exception('Failed to connect to the server: ${e.message}');
      }
    }
  }
}

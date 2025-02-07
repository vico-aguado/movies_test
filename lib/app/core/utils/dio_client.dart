import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final dio.Dio _dio = dio.Dio();

  DioClient() {
    _dio.options.baseUrl = 'https://api.themoviedb.org/3';
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);

    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) {
        final String bearerToken = dotenv.env['MOVIEDB_TOKEN'] ?? '';
        options.headers['Authorization'] = 'Bearer $bearerToken';
        final String languageCode = Get.locale?.languageCode ?? 'en';
        options.queryParameters['language'] = languageCode;
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          Get.snackbar('Error', 'Acceso no autorizado. Verifica tu token.');
        } else {
          Get.snackbar('Error', 'Ocurrió un error: ${error.message}');
        }
        return handler.next(error);
      },
    ));
  }

  Future<dio.Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

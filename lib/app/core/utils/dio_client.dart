import 'package:dio/dio.dart' as dio;
import '../constants/app_constants.dart';

typedef ErrorHandler = void Function(dio.DioException error);
typedef LanguageProvider = String Function();

class DioClient {
  final dio.Dio _dio;

  DioClient({
    dio.Dio? dioClient,
    dio.InterceptorsWrapper? interceptor,
  }) : _dio = dioClient ?? dio.Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    if (interceptor != null) {
      _dio.interceptors.add(interceptor);
    }
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

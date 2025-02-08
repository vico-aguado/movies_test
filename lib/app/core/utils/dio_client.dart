import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../constants/app_constants.dart';

typedef ErrorHandler = void Function(dio.DioException error);
typedef LanguageProvider = String Function();

class DioClient {
  final dio.Dio _dio;
  final ErrorHandler? _errorHandler;
  final LanguageProvider _languageProvider;

  DioClient({
    dio.Dio? dioClient,
    ErrorHandler? errorHandler,
    LanguageProvider? languageProvider,
  })  : _dio = dioClient ?? dio.Dio(),
        _errorHandler = errorHandler,
        _languageProvider = languageProvider ?? (() => 'en') {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) {
        final String bearerToken = dotenv.env['MOVIEDB_TOKEN'] ?? '';
        options.headers['Authorization'] = 'Bearer $bearerToken';
        final String languageCode = _languageProvider();
        options.queryParameters['language'] = languageCode;
        return handler.next(options);
      },
      onError: (error, handler) {
        _errorHandler?.call(error);
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

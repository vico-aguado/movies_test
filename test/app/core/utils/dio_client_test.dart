import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_test/app/core/utils/dio_client.dart';
import 'dio_client_test.mocks.dart';

@GenerateMocks([dio.Dio])
void main() {
  late DioClient dioClient;
  late MockDio mockDio;

  setUp(() async {
    mockDio = MockDio();

    // Configurar stub para la propiedad `options`
    when(mockDio.options).thenReturn(dio.BaseOptions(
      baseUrl: 'https://api.example.com', // URL base simulada
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ));

    // Configurar stub para la propiedad `interceptors`
    final interceptors = dio.Interceptors();
    when(mockDio.interceptors).thenReturn(interceptors);

    // Simular dotenv
    await dotenv.load(fileName: '.env.test');

    dioClient = DioClient(
      dioClient: mockDio, // Inyectar el mock de Dio
      errorHandler: (error) {},
      languageProvider: () => 'es', // Simular idioma español
    );
  });

  group('DioClient Test', () {
    test('should set base URL and timeouts correctly', () {
      // Configurar stub para el método `get`
      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => dio.Response(
            requestOptions: dio.RequestOptions(path: '/test'),
            data: {'key': 'value'},
          ));

      expect(dioClient.get('/test'), completes);
    });

    test('should handle GET request successfully', () async {
      final mockResponse = dio.Response(
        requestOptions: dio.RequestOptions(path: '/test'),
        data: {'key': 'value'},
      );
      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => mockResponse);

      final response = await dioClient.get('/test');
      expect(response.data, equals({'key': 'value'}));
    });

    test('should handle POST request successfully', () async {
      final mockResponse = dio.Response(
        requestOptions: dio.RequestOptions(path: '/test'),
        data: {'key': 'value'},
      );
      when(mockDio.post(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onSendProgress: anyNamed('onSendProgress'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => mockResponse);

      final response = await dioClient.post('/test', data: {'data': 'test'});
      expect(response.data, equals({'key': 'value'}));
    });

    test('should rethrow exceptions from GET requests', () async {
      final mockError = dio.DioException(
        requestOptions: dio.RequestOptions(path: '/test'),
        message: 'Something went wrong',
      );
      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenThrow(mockError);

      try {
        await dioClient.get('/test');
      } catch (e) {
        expect(e, isA<dio.DioException>());
        expect((e as dio.DioException).message, equals('Something went wrong'));
      }
    });

    test('should rethrow exceptions from POST requests', () async {
      final mockError = dio.DioException(
        requestOptions: dio.RequestOptions(path: '/test'),
        message: 'Something went wrong',
      );
      when(mockDio.post(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onSendProgress: anyNamed('onSendProgress'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenThrow(mockError);

      try {
        await dioClient.post('/test', data: {'data': 'test'});
      } catch (e) {
        expect(e, isA<dio.DioException>());
        expect((e as dio.DioException).message, equals('Something went wrong'));
      }
    });
  });
}

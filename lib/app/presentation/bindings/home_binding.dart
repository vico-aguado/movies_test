import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../core/services/alerts_service.dart';
import '../../core/utils/dio_client.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_movie_genres.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final dioClient = DioClient(
        interceptor: InterceptorsWrapper(
      onRequest: (options, handler) {
        final String bearerToken = dotenv.env['MOVIEDB_TOKEN'] ?? '';
        options.headers['Authorization'] = 'Bearer $bearerToken';
        final String languageCode = Get.locale?.languageCode ?? 'en';
        options.queryParameters['language'] = languageCode;
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          Get.snackbar('Error', 'auth_error'.tr);
        } else {
          Get.snackbar('Error', '${'generic_error'.tr} ${error.message}');
        }
        return handler.next(error);
      },
    ));
    final movieRepository = MovieRepositoryImpl(dioClient);
    final getPopularMovies = GetPopularMovies(movieRepository);
    final getMovieGenres = GetMovieGenres(movieRepository);

    Get.lazyPut(() => HomeController(
          getPopularMovies: getPopularMovies,
          getMovieGenres: getMovieGenres,
          settingsController: Get.find(),
          alertsService: AlertsService(),
        ));
  }
}

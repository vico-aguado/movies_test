import 'package:get/get.dart';

import '../../core/utils/dio_client.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_movie_genres.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final dioClient = DioClient(
      errorHandler: (error) {
        if (error.response?.statusCode == 401) {
          Get.snackbar('Error', 'Acceso no autorizado. Verifica tu token.');
        } else {
          Get.snackbar('Error', 'Ocurrió un error: ${error.message}');
        }
      },
      languageProvider: () => Get.locale?.languageCode ?? 'en',
    );
    final movieRepository = MovieRepositoryImpl(dioClient);
    final getPopularMovies = GetPopularMovies(movieRepository);
    final getMovieGenres = GetMovieGenres(movieRepository);

    Get.lazyPut(() => HomeController(
          getPopularMovies: getPopularMovies,
          getMovieGenres: getMovieGenres,
          settingsController: Get.find(),
        ));
  }
}

import 'package:get/get.dart';

import '../../core/utils/dio_client.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_movie_genres.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final dioClient = DioClient();
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

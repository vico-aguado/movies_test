import 'package:get/get.dart';
import '../../domain/usecases/get_movie_genres.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/entities/movie_entity.dart';

class HomeController extends GetxController {
  final GetPopularMovies getPopularMovies;
  final GetMovieGenres getMovieGenres;
  var movies = <MovieEntity>[].obs;
  var isLoading = true.obs;
  Map<int, String> genreMap = {};

  HomeController({
    required this.getPopularMovies,
    required this.getMovieGenres,
  });

  @override
  void onInit() {
    super.onInit();
    fetchPopularMoviesAndGenres();
  }

  Future<void> fetchPopularMoviesAndGenres() async {
    try {
      isLoading.value = true;

      genreMap = await getMovieGenres();

      final fetchedMovies = await getPopularMovies();
      movies.value = fetchedMovies.map((movie) {
        final genreNames = movie.genreIds
            .map((id) => genreMap[id] ?? 'Unknown')
            .toList()
            .join(', ');
        return MovieEntity(
          id: movie.id,
          title: movie.title,
          overview: movie.overview,
          posterPath: movie.posterPath,
          releaseDate: movie.releaseDate,
          genreIds: movie.genreIds,
          genres: genreNames,
        );
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las películas.');
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../domain/entities/paginated_response_entity.dart';
import '../../domain/usecases/get_movie_genres.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/entities/movie_entity.dart';
import 'settings_controller.dart';

class HomeController extends GetxController {
  final GetPopularMovies getPopularMovies;
  final GetMovieGenres getMovieGenres;
  final SettingsController settingsController;

  var movies = <MovieEntity>[].obs;
  var isLoading = true.obs;
  var currentPage = 1;
  var totalPages = 1;
  Map<int, String> genreMap = {};

  final ScrollController scrollController = ScrollController();

  HomeController({
    required this.getPopularMovies,
    required this.getMovieGenres,
    required this.settingsController,
  });

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
    ever(settingsController.currentLanguage, (_) {
      resetAndFetchMovies();
    });
  }

  Future<void> fetchInitialData() async {
    isLoading.value = true;
    try {
      genreMap = await getMovieGenres();

      await fetchMovies();
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las películas o géneros.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMovies() async {
    if (currentPage > totalPages) return;

    try {
      isLoading.value = true;
      final PaginatedResponseEntity result =
          await getPopularMovies(page: currentPage);
      totalPages = result.totalPages;
      movies.addAll(result.movies.map((movie) {
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
      }).toList());
      currentPage++;
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar más películas.');
    } finally {
      isLoading.value = false;
    }
  }

  void resetAndFetchMovies() {
    movies.clear();
    currentPage = 1;
    totalPages = 1;
    fetchMovies();
  }

  void loadMoreMovies() {
    if (!isLoading.value) {
      fetchMovies();
    }
  }
}

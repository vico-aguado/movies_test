import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../core/services/alerts_service.dart';
import '../../domain/entities/paginated_response_entity.dart';
import '../../domain/usecases/get_movie_genres.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/entities/movie_entity.dart';
import 'settings_controller.dart';

class HomeController extends GetxController {
  final GetPopularMovies getPopularMovies;
  final GetMovieGenres getMovieGenres;
  final SettingsController settingsController;
  final AlertsService alertsService;

  var movies = <MovieEntity>[].obs;
  var filteredMovies = <MovieEntity>[].obs;
  var isLoading = true.obs;
  var currentPage = 1;
  var totalPages = 1;
  String _currentQuery = '';
  Map<int, String> genreMap = {};

  final ScrollController scrollController = ScrollController();

  HomeController({
    required this.getPopularMovies,
    required this.getMovieGenres,
    required this.settingsController,
    required this.alertsService,
  });

  @override
  void onInit() {
    super.onInit();
    ever(settingsController.currentLanguage, (_) {
      resetAndFetchMovies();
    });
  }

  Future<void> fetchMovies() async {
    if (currentPage > totalPages) return;

    try {
      isLoading.value = true;
      genreMap = await getMovieGenres();
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
          backdropPath: movie.backdropPath,
          releaseDate: movie.releaseDate,
          genreIds: movie.genreIds,
          genres: genreNames,
        );
      }).toList());

      filterMovies(_currentQuery);
      currentPage++;
    } catch (e) {
      alertsService.showErrorMessage(
        'Error',
        'error_loading_movies'.tr,
      );
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

  void filterMovies(String query) {
    _currentQuery = query.toLowerCase();
    if (_currentQuery.isEmpty) {
      filteredMovies.assignAll(movies);
    } else {
      filteredMovies.assignAll(
        movies
            .where((movie) => movie.title.toLowerCase().contains(_currentQuery))
            .toList(),
      );
    }
  }
}

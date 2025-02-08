import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:movies_test/app/core/services/alerts_service.dart';
import 'package:movies_test/app/core/services/preferences_service.dart';
import 'package:movies_test/app/core/theme/theme_controller.dart';
import 'package:movies_test/app/domain/entities/movie_entity.dart';
import 'package:movies_test/app/domain/entities/paginated_response_entity.dart';
import 'package:movies_test/app/domain/usecases/get_movie_genres.dart';
import 'package:movies_test/app/domain/usecases/get_popular_movies.dart';
import 'package:movies_test/app/presentation/controllers/home_controller.dart';
import 'package:movies_test/app/presentation/controllers/settings_controller.dart';

import 'home_controller_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
  GetMovieGenres,
  AlertsService,
  PreferencesService,
  ThemeController,
])
void main() {
  late HomeController controller;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetMovieGenres mockGetMovieGenres;
  late MockAlertsService mockAlertsService;
  late SettingsController settingsController;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetMovieGenres = MockGetMovieGenres();
    mockAlertsService = MockAlertsService();

    final mockPreferencesService = MockPreferencesService();
    when(mockPreferencesService.getLanguage()).thenAnswer((_) async => 'en');

    settingsController = SettingsController(
      themeController: MockThemeController(),
      preferencesService: mockPreferencesService,
    );

    controller = HomeController(
      getPopularMovies: mockGetPopularMovies,
      getMovieGenres: mockGetMovieGenres,
      settingsController: settingsController,
      alertsService: mockAlertsService,
    );
  });

  group('HomeController Tests', () {
    test('fetchInitialData calls fetchMovies and handles errors', () async {
      // Arrange
      when(mockGetMovieGenres())
          .thenAnswer((_) async => {1: 'Action', 2: 'Drama'});
      when(mockGetPopularMovies(page: anyNamed('page'))).thenAnswer(
          (_) async => PaginatedResponseEntity(movies: [], totalPages: 0));

      // Act
      await controller.fetchMovies();

      // Assert
      expect(controller.isLoading.value, false);
      verify(mockGetMovieGenres()).called(1);
      verify(mockGetPopularMovies(page: anyNamed('page'))).called(1);
    });

    test('fetchMovies updates movies and handles genres correctly', () async {
      // Arrange
      final mockMovies = [
        MovieEntity(
          id: 1,
          title: 'Movie 1',
          overview: 'Overview 1',
          posterPath: '/poster1.jpg',
          backdropPath: '/backdrop1.jpg',
          releaseDate: '2023-01-01',
          genreIds: [1, 2],
        ),
      ];
      when(mockGetMovieGenres())
          .thenAnswer((_) async => {1: 'Action', 2: 'Drama'});
      when(mockGetPopularMovies(page: anyNamed('page'))).thenAnswer((_) async =>
          PaginatedResponseEntity(movies: mockMovies, totalPages: 1));

      // Act
      await controller.fetchMovies();

      // Assert
      expect(controller.movies.length, 1);
      expect(controller.movies[0].genres, 'Action, Drama');
      expect(controller.currentPage, 2);
      expect(controller.totalPages, 1);
      expect(controller.isLoading.value, false);
    });

    test('fetchMovies shows error message on failure', () async {
      // Arrange
      when(mockGetMovieGenres()).thenThrow(Exception('Error fetching genres'));
      when(mockGetPopularMovies(page: anyNamed('page')))
          .thenThrow(Exception('Error fetching movies'));

      // Act
      await controller.fetchMovies();

      // Assert
      verify(mockAlertsService.showErrorMessage(
              'Error', 'error_loading_movies'))
          .called(1);
      expect(controller.isLoading.value, false);
    });

    test('resetAndFetchMovies resets state and fetches movies', () async {
      // Arrange
      controller.movies.addAll([
        MovieEntity(
          id: 1,
          title: 'Movie 1',
          overview: 'Overview 1',
          posterPath: '/poster1.jpg',
          backdropPath: '/backdrop1.jpg',
          releaseDate: '2023-01-01',
          genreIds: [1, 2],
        ),
      ]);
      controller.currentPage = 5;
      controller.totalPages = 10;

      when(mockGetMovieGenres.call())
          .thenAnswer((_) async => {1: 'Action', 2: 'Drama'});
      when(mockGetPopularMovies(page: anyNamed('page'))).thenAnswer(
          (_) async => PaginatedResponseEntity(movies: [], totalPages: 0));

      // Act
      controller.resetAndFetchMovies();

      await Future.delayed(Duration(milliseconds: 100));

      // Assert
      expect(controller.movies.isEmpty, true);
      expect(controller.currentPage, 2);
      expect(controller.totalPages, 0);
      verify(mockGetMovieGenres()).called(1);
      verify(mockGetPopularMovies(page: anyNamed('page'))).called(1);
    });

    test('filterMovies filters movies by query', () {
      // Arrange
      controller.movies.addAll([
        MovieEntity(
          id: 1,
          title: 'Movie 1',
          overview: 'Overview 1',
          posterPath: '/poster1.jpg',
          backdropPath: '/backdrop1.jpg',
          releaseDate: '2023-01-01',
          genreIds: [1, 2],
        ),
        MovieEntity(
          id: 2,
          title: 'Movie 2',
          overview: 'Overview 2',
          posterPath: '/poster2.jpg',
          backdropPath: '/backdrop2.jpg',
          releaseDate: '2023-01-01',
          genreIds: [1, 2],
        ),
      ]);

      // Act
      controller.filterMovies('movie 1');

      // Assert
      expect(controller.filteredMovies.length, 1);
      expect(controller.filteredMovies[0].title, 'Movie 1');
    });

    test('loadMoreMovies calls fetchMovies if not loading', () async {
      // Arrange
      controller.isLoading.value = false;
      when(mockGetMovieGenres())
          .thenAnswer((_) async => {1: 'Action', 2: 'Drama'});
      when(mockGetPopularMovies(page: anyNamed('page'))).thenAnswer(
          (_) async => PaginatedResponseEntity(movies: [], totalPages: 0));

      // Act
      controller.loadMoreMovies();

      await Future.delayed(Duration(milliseconds: 100));

      // Assert
      verify(mockGetMovieGenres()).called(1);
      verify(mockGetPopularMovies(page: anyNamed('page'))).called(1);
    });

    test('loadMoreMovies does not call fetchMovies if loading', () async {
      // Arrange
      controller.isLoading.value = true;

      // Act
      controller.loadMoreMovies();

      // Assert
      verifyNever(mockGetMovieGenres());
      verifyNever(mockGetPopularMovies(page: anyNamed('page')));
    });

    test('onInit sets up listener for settingsController.currentLanguage', () {
      // Arrange
      expect(controller.movies.isEmpty,
          true); // Asegurarse de que la lista esté vacía inicialmente

      // Act
      controller.onInit(); // Llama a onInit para configurar el listener
      settingsController.currentLanguage.value =
          'es'; // Simula un cambio de idioma

      // Assert
      expect(
          controller.movies.isEmpty, true); // Verifica que se haya reiniciado
    });
  });
}

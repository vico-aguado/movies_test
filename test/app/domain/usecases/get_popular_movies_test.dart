import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/domain/entities/genre_entity.dart';
import 'package:movies_test/app/domain/entities/movie_entity.dart';
import 'package:movies_test/app/domain/entities/paginated_response_entity.dart';
import 'package:movies_test/app/domain/repositories/movie_repository.dart';
import 'package:movies_test/app/domain/usecases/get_popular_movies.dart';

class FakeMovieRepository implements MovieRepository {
  @override
  Future<PaginatedResponseEntity> getPopularMovies({required int page}) async {
    final movies = [
      MovieEntity(
        id: 1,
        title: 'Movie 1',
        overview: 'Overview 1',
        posterPath: '/poster1.jpg',
        backdropPath: '/backdrop1.jpg',
      ),
      MovieEntity(
        id: 2,
        title: 'Movie 2',
        overview: 'Overview 2',
        posterPath: '/poster2.jpg',
        backdropPath: '/backdrop2.jpg',
      ),
    ];
    return PaginatedResponseEntity(movies: movies, totalPages: 5);
  }

  @override
  Future<List<GenreEntity>> getMovieGenres() {
    throw UnimplementedError();
  }
}

class FakeMovieRepositoryEmpty implements MovieRepository {
  @override
  Future<PaginatedResponseEntity> getPopularMovies({required int page}) async {
    return PaginatedResponseEntity(movies: [], totalPages: 0);
  }

  @override
  Future<List<GenreEntity>> getMovieGenres() {
    throw UnimplementedError();
  }
}

void main() {
  group('GetPopularMovies Tests', () {
    late GetPopularMovies getPopularMovies;

    setUp(() {
      final repository = FakeMovieRepository();
      getPopularMovies = GetPopularMovies(repository);
    });

    test('call returns PaginatedResponseEntity with movies and totalPages',
        () async {
      const page = 1;
      final result = await getPopularMovies.call(page: page);

      expect(result.movies.length, 2);
      expect(result.movies[0].id, 1);
      expect(result.movies[0].title, 'Movie 1');
      expect(result.movies[1].id, 2);
      expect(result.movies[1].title, 'Movie 2');
      expect(result.totalPages, 5);
    });

    test('call handles empty movies list correctly', () async {
      // Usamos un repositorio que devuelve una lista vacía
      final repository = FakeMovieRepositoryEmpty();
      getPopularMovies = GetPopularMovies(repository);

      const page = 1;
      final result = await getPopularMovies.call(page: page);

      expect(result.movies, isEmpty);
      expect(result.totalPages, 0);
    });
  });
}

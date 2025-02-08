import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/domain/entities/paginated_response_entity.dart';
import 'package:movies_test/app/domain/entities/movie_entity.dart';
import 'package:movies_test/app/domain/entities/genre_entity.dart';
import 'package:movies_test/app/domain/repositories/movie_repository.dart';

class FakeMovieRepository implements MovieRepository {
  @override
  Future<PaginatedResponseEntity> getPopularMovies({required int page}) async {
    final movies = [
      MovieEntity(
        id: 1,
        title: 'Fake Movie',
        overview: 'This is a fake movie',
        posterPath: '/fake_poster.jpg',
        backdropPath: '/fake_backdrop.jpg',
      ),
    ];
    return PaginatedResponseEntity(movies: movies, totalPages: 1);
  }

  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    return [
      GenreEntity(id: 1, name: 'Action'),
      GenreEntity(id: 2, name: 'Drama'),
    ];
  }
}

void main() {
  group('MovieRepository Tests', () {
    late MovieRepository movieRepository;

    setUp(() {
      movieRepository = FakeMovieRepository();
    });

    test('getPopularMovies returns PaginatedResponseEntity', () async {
      const page = 1;
      final result = await movieRepository.getPopularMovies(page: page);

      expect(result.movies.length, 1);
      expect(result.movies[0].id, 1);
      expect(result.movies[0].title, 'Fake Movie');
      expect(result.totalPages, 1);
    });

    test('getMovieGenres returns List<GenreEntity>', () async {
      final result = await movieRepository.getMovieGenres();

      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].name, 'Action');
      expect(result[1].id, 2);
      expect(result[1].name, 'Drama');
    });
  });
}

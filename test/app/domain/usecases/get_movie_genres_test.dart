import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/domain/entities/genre_entity.dart';
import 'package:movies_test/app/domain/entities/paginated_response_entity.dart';
import 'package:movies_test/app/domain/repositories/movie_repository.dart';
import 'package:movies_test/app/domain/usecases/get_movie_genres.dart';

class FakeMovieRepository implements MovieRepository {
  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    return [
      GenreEntity(id: 1, name: 'Action'),
      GenreEntity(id: 2, name: 'Drama'),
      GenreEntity(id: 3, name: 'Comedy'),
    ];
  }

  @override
  Future<PaginatedResponseEntity> getPopularMovies({required int page}) {
    throw UnimplementedError();
  }
}

class FakeMovieRepositoryEmpty implements MovieRepository {
  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    return [];
  }

  @override
  Future<PaginatedResponseEntity> getPopularMovies({required int page}) {
    throw UnimplementedError();
  }
}

void main() {
  group('GetMovieGenres Tests', () {
    late GetMovieGenres getMovieGenres;

    setUp(() {
      final repository = FakeMovieRepository();
      getMovieGenres = GetMovieGenres(repository);
    });

    test('call returns a map of genre IDs to genre names', () async {
      final result = await getMovieGenres.call();

      expect(result, {
        1: 'Action',
        2: 'Drama',
        3: 'Comedy',
      });
    });

    test('call handles empty genres list correctly', () async {
      final repository = FakeMovieRepositoryEmpty();
      getMovieGenres = GetMovieGenres(repository);

      final result = await getMovieGenres.call();

      expect(result, {});
    });
  });
}

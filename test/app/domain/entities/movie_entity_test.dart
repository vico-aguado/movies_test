import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/domain/entities/movie_entity.dart';

void main() {
  group('MovieEntity Tests', () {
    test('MovieEntity constructor assigns values correctly', () {
      const id = 1;
      const title = 'Test Movie';
      const overview = 'This is a test movie';
      const posterPath = '/test_poster.jpg';
      const backdropPath = '/test_backdrop.jpg';
      const releaseDate = '2023-10-01';
      const genreIds = [1, 2, 3];
      const genres = 'Action, Drama';

      final movieEntity = MovieEntity(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
        releaseDate: releaseDate,
        genreIds: genreIds,
        genres: genres,
      );

      expect(movieEntity.id, id);
      expect(movieEntity.title, title);
      expect(movieEntity.overview, overview);
      expect(movieEntity.posterPath, posterPath);
      expect(movieEntity.backdropPath, backdropPath);
      expect(movieEntity.releaseDate, releaseDate);
      expect(movieEntity.genreIds, genreIds);
      expect(movieEntity.genres, genres);
    });

    test('MovieEntity equality works correctly', () {
      const id = 2;
      const title = 'Test Movie 2';
      const overview = 'This is another test movie';
      const posterPath = '/test_poster_2.jpg';
      const backdropPath = '/test_backdrop_2.jpg';
      const releaseDate = '2023-11-01';
      const genreIds = [4, 5];
      const genres = 'Comedy, Thriller';

      final movieEntity1 = MovieEntity(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
        releaseDate: releaseDate,
        genreIds: genreIds,
        genres: genres,
      );

      final movieEntity2 = MovieEntity(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
        releaseDate: releaseDate,
        genreIds: genreIds,
        genres: genres,
      );

      expect(movieEntity1, equals(movieEntity2));
    });

    test('MovieEntity hashCode is consistent with equality', () {
      const id = 3;
      const title = 'Test Movie 3';
      const overview = 'Another test movie';
      const posterPath = '/test_poster_3.jpg';
      const backdropPath = '/test_backdrop_3.jpg';
      const releaseDate = '2023-12-01';
      const genreIds = [6, 7];
      const genres = 'Romance, Sci-Fi';

      final movieEntity1 = MovieEntity(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
        releaseDate: releaseDate,
        genreIds: genreIds,
        genres: genres,
      );

      final movieEntity2 = MovieEntity(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
        releaseDate: releaseDate,
        genreIds: genreIds,
        genres: genres,
      );

      expect(movieEntity1.hashCode, equals(movieEntity2.hashCode));
    });

    test('MovieEntity default values are assigned correctly', () {
      const id = 4;
      const title = 'Default Test Movie';
      const overview = 'Default overview';
      const posterPath = '/default_poster.jpg';
      const backdropPath = '/default_backdrop.jpg';

      final movieEntity = MovieEntity(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
      );

      expect(movieEntity.releaseDate, 'N/A');
      expect(movieEntity.genreIds, []);
      expect(movieEntity.genres, '');
    });
  });
}

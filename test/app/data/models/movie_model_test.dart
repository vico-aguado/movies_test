import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/data/models/movie_model.dart';

void main() {
  group('MovieModel Tests', () {
    test('fromJson constructs MovieModel correctly', () {
      const id = 1;
      const title = 'Test Movie';
      const overview = 'This is a test movie';
      const posterPath = '/test_poster.jpg';
      const backdropPath = '/test_backdrop.jpg';
      const genreIds = [1, 2, 3];
      const releaseDate = '2023-10-01';

      final json = {
        'id': id,
        'title': title,
        'overview': overview,
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
        'genre_ids': genreIds,
        'release_date': releaseDate,
      };

      final movieModel = MovieModel.fromJson(json);

      expect(movieModel.id, id);
      expect(movieModel.title, title);
      expect(movieModel.overview, overview);
      expect(movieModel.posterPath, posterPath);
      expect(movieModel.backdropPath, backdropPath);
      expect(movieModel.genreIds, genreIds);
      expect(movieModel.releaseDate, releaseDate);
      expect(movieModel.genres, '');
    });

    test('fromJson handles null backdropPath correctly', () {
      const id = 2;
      const title = 'Test Movie 2';
      const overview = 'This is another test movie';
      const posterPath = '/test_poster_2.jpg';
      const genreIds = [4, 5];
      const releaseDate = '2023-11-01';

      final json = {
        'id': id,
        'title': title,
        'overview': overview,
        'poster_path': posterPath,
        'backdrop_path': null,
        'genre_ids': genreIds,
        'release_date': releaseDate,
      };

      final movieModel = MovieModel.fromJson(json);

      expect(movieModel.id, id);
      expect(movieModel.title, title);
      expect(movieModel.overview, overview);
      expect(movieModel.posterPath, posterPath);
      expect(movieModel.backdropPath, '');
      expect(movieModel.genreIds, genreIds);
      expect(movieModel.releaseDate, releaseDate);
      expect(movieModel.genres, '');
    });

    test('MovieModel constructor assigns values correctly', () {
      const id = 3;
      const title = 'Test Movie 3';
      const overview = 'Another test movie';
      const posterPath = '/test_poster_3.jpg';
      const backdropPath = '/test_backdrop_3.jpg';
      const genreIds = [6, 7];
      const releaseDate = '2023-12-01';
      const genres = '';

      final movieModel = MovieModel(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
        genreIds: genreIds,
        releaseDate: releaseDate,
        genres: genres,
      );

      expect(movieModel.id, id);
      expect(movieModel.title, title);
      expect(movieModel.overview, overview);
      expect(movieModel.posterPath, posterPath);
      expect(movieModel.backdropPath, backdropPath);
      expect(movieModel.genreIds, genreIds);
      expect(movieModel.releaseDate, releaseDate);
      expect(movieModel.genres, genres);
    });
  });
}

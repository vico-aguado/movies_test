import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/domain/entities/movie_entity.dart';
import 'package:movies_test/app/domain/entities/paginated_response_entity.dart';

void main() {
  group('PaginatedResponseEntity Tests', () {
    test('PaginatedResponseEntity constructor assigns values correctly', () {
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
      const totalPages = 5;

      final response = PaginatedResponseEntity(
        movies: movies,
        totalPages: totalPages,
      );

      expect(response.movies, equals(movies));
      expect(response.totalPages, equals(totalPages));
    });

    test('PaginatedResponseEntity equality works correctly', () {
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
      const totalPages = 5;

      final response1 = PaginatedResponseEntity(
        movies: movies,
        totalPages: totalPages,
      );

      final response2 = PaginatedResponseEntity(
        movies: movies,
        totalPages: totalPages,
      );

      expect(response1, equals(response2));
    });

    test('PaginatedResponseEntity hashCode is consistent with equality', () {
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
      const totalPages = 5;

      final response1 = PaginatedResponseEntity(
        movies: movies,
        totalPages: totalPages,
      );

      final response2 = PaginatedResponseEntity(
        movies: movies,
        totalPages: totalPages,
      );

      expect(response1.hashCode, equals(response2.hashCode));
    });
  });
}

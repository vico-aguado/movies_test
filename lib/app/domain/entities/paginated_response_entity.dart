import 'movie_entity.dart';

class PaginatedResponseEntity {
  final List<MovieEntity> movies;
  final int totalPages;

  PaginatedResponseEntity({
    required this.movies,
    required this.totalPages,
  });
}

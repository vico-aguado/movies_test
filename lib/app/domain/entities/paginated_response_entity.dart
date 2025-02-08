import 'movie_entity.dart';

class PaginatedResponseEntity {
  final List<MovieEntity> movies;
  final int totalPages;

  PaginatedResponseEntity({
    required this.movies,
    required this.totalPages,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginatedResponseEntity &&
        other.movies == movies &&
        other.totalPages == totalPages;
  }

  @override
  int get hashCode => Object.hash(movies, totalPages);
}

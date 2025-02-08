class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final List<int> genreIds;
  final String genres;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    this.releaseDate = 'N/A',
    this.genreIds = const [],
    this.genres = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MovieEntity &&
        other.id == id &&
        other.title == title &&
        other.overview == overview &&
        other.posterPath == posterPath &&
        other.backdropPath == backdropPath &&
        other.releaseDate == releaseDate &&
        other.genreIds == genreIds &&
        other.genres == genres;
  }

  @override
  int get hashCode => Object.hash(
        id,
        title,
        overview,
        posterPath,
        backdropPath,
        releaseDate,
        genreIds,
        genres,
      );
}

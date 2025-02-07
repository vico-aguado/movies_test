class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final List<int> genreIds;
  final String genres;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    this.releaseDate = 'N/A',
    this.genreIds = const [],
    this.genres = '',
  });
}

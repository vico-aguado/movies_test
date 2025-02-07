import '../repositories/movie_repository.dart';

class GetMovieGenres {
  final MovieRepository repository;

  GetMovieGenres(this.repository);

  Future<Map<int, String>> call() async {
    final genres = await repository.getMovieGenres();
    return {for (var genre in genres) genre.id: genre.name};
  }
}

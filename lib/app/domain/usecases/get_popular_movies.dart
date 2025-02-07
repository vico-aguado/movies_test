import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<List<MovieEntity>> call() async {
    return await repository.getPopularMovies();
  }
}

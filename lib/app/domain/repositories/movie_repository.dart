import '../entities/genre_entity.dart';
import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getPopularMovies();
  Future<List<GenreEntity>> getMovieGenres();
}

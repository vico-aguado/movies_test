import '../entities/genre_entity.dart';
import '../entities/paginated_response_entity.dart';

abstract class MovieRepository {
  Future<PaginatedResponseEntity> getPopularMovies({required int page});
  Future<List<GenreEntity>> getMovieGenres();
}

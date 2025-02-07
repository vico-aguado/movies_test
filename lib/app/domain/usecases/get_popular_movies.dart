import '../entities/paginated_response_entity.dart';
import '../repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<PaginatedResponseEntity> call({required int page}) async {
    return await repository.getPopularMovies(page: page);
  }
}

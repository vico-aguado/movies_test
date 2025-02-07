import '../../core/utils/dio_client.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/entities/paginated_response_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/genre_model.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DioClient _dioClient;

  MovieRepositoryImpl(this._dioClient);

  @override
  Future<PaginatedResponseEntity> getPopularMovies({required int page}) async {
    try {
      final response = await _dioClient.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );
      final List<dynamic> results = response.data['results'];
      final totalPages = response.data['total_pages'] ?? 1;
      return PaginatedResponseEntity(
        movies: results.map((json) => MovieModel.fromJson(json)).toList(),
        totalPages: totalPages,
      );
    } catch (e) {
      throw Exception('Error al obtener las películas populares: $e');
    }
  }

  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    try {
      final response = await _dioClient.get('/genre/movie/list');
      final List<dynamic> genres = response.data['genres'];
      return genres.map((json) => GenreModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener los géneros: $e');
    }
  }
}

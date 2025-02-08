import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:movies_test/app/core/utils/dio_client.dart';
import 'package:movies_test/app/data/repositories/movie_repository_impl.dart';
import 'movie_repository_impl_test.mocks.dart';

@GenerateMocks([DioClient])
void main() {
  late MovieRepositoryImpl movieRepository;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    movieRepository = MovieRepositoryImpl(mockDioClient);
  });

  group('getPopularMovies', () {
    test('returns PaginatedResponseEntity with movies and totalPages',
        () async {
      const page = 1;
      final mockResponseData = {
        'results': [
          {
            'id': 1,
            'title': 'Movie 1',
            'overview': 'Overview 1',
            'poster_path': '/poster1.jpg',
            'backdrop_path': '/backdrop1.jpg',
            'genre_ids': [1, 2],
            'release_date': '2023-01-01',
          },
          {
            'id': 2,
            'title': 'Movie 2',
            'overview': 'Overview 2',
            'poster_path': '/poster2.jpg',
            'backdrop_path': null,
            'genre_ids': [3, 4],
            'release_date': '2023-02-01',
          },
        ],
        'total_pages': 5,
      };

      when(mockDioClient.get(
        '/movie/popular',
        queryParameters: {
          'page': page,
          'sort_by': 'popularity.desc',
          'with_release_type': '2|3',
          'include_adult': 'false',
          'include_video': 'false',
        },
      )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/movie/popular'),
            data: mockResponseData,
          ));

      final result = await movieRepository.getPopularMovies(page: page);

      expect(result.movies.length, 2);
      expect(result.movies[0].id, 1);
      expect(result.movies[0].title, 'Movie 1');
      expect(result.movies[1].id, 2);
      expect(result.movies[1].title, 'Movie 2');
      expect(result.totalPages, 5);
    });

    test('throws Exception when DioClient fails', () async {
      const page = 1;

      when(mockDioClient.get(
        '/movie/popular',
        queryParameters: {
          'page': page,
          'sort_by': 'popularity.desc',
          'with_release_type': '2|3',
          'include_adult': 'false',
          'include_video': 'false',
        },
      )).thenThrow(Exception('Dio Error'));

      expect(
          () => movieRepository.getPopularMovies(page: page), throwsException);
    });
  });

  group('getMovieGenres', () {
    test('returns list of GenreEntity', () async {
      final mockResponseData = {
        'genres': [
          {'id': 1, 'name': 'Action'},
          {'id': 2, 'name': 'Drama'},
        ],
      };

      when(mockDioClient.get('/genre/movie/list'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/genre/movie/list'),
                data: mockResponseData,
              ));

      final result = await movieRepository.getMovieGenres();

      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].name, 'Action');
      expect(result[1].id, 2);
      expect(result[1].name, 'Drama');
    });

    test('throws Exception when DioClient fails', () async {
      when(mockDioClient.get('/genre/movie/list'))
          .thenThrow(Exception('Dio Error'));

      expect(() => movieRepository.getMovieGenres(), throwsException);
    });
  });
}

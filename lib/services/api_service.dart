import 'package:court_click_task/core/network/end_points.dart';
import 'package:court_click_task/models/now_playing_movie_model.dart';
import 'package:court_click_task/models/popular_movies_model.dart';
import 'package:court_click_task/models/top_rated_movie_model.dart';
import 'package:court_click_task/models/trending_movies_model.dart';
import 'package:court_click_task/models/up_coming_movie_model.dart';
import 'dio_client.dart';

class ApiService {
  final DioClient dioClient;

  ApiService({DioClient? client}) : dioClient = client ?? DioClient();

  Future<TrendingMoviesModel> getTrendingMovies({int page = 1}) async {
    final data = await dioClient.get(
      Endpoints.trending,
      queryParameters: {'page': page},
    );
    return TrendingMoviesModel.fromJson(data as Map<String, dynamic>);
  }

  Future<PopularMoviesModel> getPopularMovies({int page = 1}) async {
    final data = await dioClient.get(
      Endpoints.popular,
      queryParameters: {'page': page},
    );
    return PopularMoviesModel.fromJson(data as Map<String, dynamic>);
  }

  Future<NowPlayingMovieModel> getNowPlayingMovies({int page = 1}) async {
    final data = await dioClient.get(
      Endpoints.nowPlaying,
      queryParameters: {'page': page},
    );
    return NowPlayingMovieModel.fromJson(data as Map<String, dynamic>);
  }

  Future<TopRatedMovieModel> getTopRatedMovies({int page = 1}) async {
    final data = await dioClient.get(
      Endpoints.topRated,
      queryParameters: {'page': page},
    );
    return TopRatedMovieModel.fromJson(data as Map<String, dynamic>);
  }

  Future<UpComingMovieModel> getUpcomingMovies({int page = 1}) async {
    final data = await dioClient.get(
      Endpoints.upcoming,
      queryParameters: {'page': page},
    );
    return UpComingMovieModel.fromJson(data as Map<String, dynamic>);
  }

  Future<TrendingMoviesModel> searchMovies(String query, {int page = 1}) async {
    if (query.trim().isEmpty) return TrendingMoviesModel(results: []);
    final data = await dioClient.get(
      Endpoints.search,
      queryParameters: {'query': query, 'page': page},
    );
    return TrendingMoviesModel.fromJson(data as Map<String, dynamic>);
  }
}

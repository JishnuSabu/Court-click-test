import 'package:court_click_task/core/network/api_handle.dart';
import 'package:court_click_task/core/network/api_status.dart';
import 'package:court_click_task/models/now_playing_movie_model.dart';
import 'package:court_click_task/models/popular_movies_model.dart';
import 'package:court_click_task/models/top_rated_movie_model.dart';
import 'package:court_click_task/models/trending_movies_model.dart';
import 'package:court_click_task/models/up_coming_movie_model.dart';
import 'package:court_click_task/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with ApiHandler {
  final ApiService apiService;

  HomeBloc({required this.apiService}) : super(const HomeInitial()) {
    on<FetchHomeMovies>(_onFetchHomeMovies);
    on<RefreshHomeMovies>(_onRefreshHomeMovies);
  }

  Future<void> _onFetchHomeMovies(
    FetchHomeMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    await _loadHomeData(emit);
  }

  Future<void> _onRefreshHomeMovies(
    RefreshHomeMovies event,
    Emitter<HomeState> emit,
  ) async {
    await _loadHomeData(emit);
  }

  Future<void> _loadHomeData(Emitter<HomeState> emit) async {
    final trendingApiResponse = await handleApi<TrendingMoviesModel>(
      () async => await apiService.getTrendingMovies(),
    );
    final popularApiResponse = await handleApi<PopularMoviesModel>(
      () async => await apiService.getPopularMovies(),
    );
    final topRatedApiResponse = await handleApi<TopRatedMovieModel>(
      () async => await apiService.getTopRatedMovies(),
    );
    final nowPlayingApiResponse = await handleApi<NowPlayingMovieModel>(
      () async => await apiService.getNowPlayingMovies(),
    );
    final upcomingApiResponse = await handleApi<UpComingMovieModel>(
      () async => await apiService.getUpcomingMovies(),
    );

    if (trendingApiResponse.status == ApiStatus.success ||
        popularApiResponse.status == ApiStatus.success) {
      final trendingModel =
          trendingApiResponse.data ?? TrendingMoviesModel(results: []);
      final popularModel =
          popularApiResponse.data ?? PopularMoviesModel(results: []);
      final topRatedModel =
          topRatedApiResponse.data ?? TopRatedMovieModel(results: []);
      final nowPlayingModel =
          nowPlayingApiResponse.data ?? NowPlayingMovieModel(results: []);
      final upcomingModel =
          upcomingApiResponse.data ?? UpComingMovieModel(results: []);

      if ((trendingModel.results == null || trendingModel.results!.isEmpty) &&
          (popularModel.results == null || popularModel.results!.isEmpty)) {
        emit(
          const HomeError('No movies available right now. Please try again.'),
        );
        return;
      }

      emit(
        HomeLoaded(
          trendingMoviesModel: trendingModel,
          popularMoviesModel: popularModel,
          topRatedMovieModel: topRatedModel,
          nowPlayingMovieModel: nowPlayingModel,
          upComingMovieModel: upcomingModel,
        ),
      );
    } else {
      final errorMsg =
          trendingApiResponse.message ??
          popularApiResponse.message ??
          'Unable to fetch home data';
      emit(HomeError(errorMsg));
    }
  }
}

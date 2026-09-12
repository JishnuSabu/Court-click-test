import 'package:court_click_task/models/now_playing_movie_model.dart';
import 'package:court_click_task/models/popular_movies_model.dart';
import 'package:court_click_task/models/top_rated_movie_model.dart';
import 'package:court_click_task/models/trending_movies_model.dart';
import 'package:court_click_task/models/up_coming_movie_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final TrendingMoviesModel trendingMoviesModel;
  final PopularMoviesModel popularMoviesModel;
  final TopRatedMovieModel topRatedMovieModel;
  final NowPlayingMovieModel nowPlayingMovieModel;
  final UpComingMovieModel upComingMovieModel;

  const HomeLoaded({
    required this.trendingMoviesModel,
    required this.popularMoviesModel,
    required this.topRatedMovieModel,
    required this.nowPlayingMovieModel,
    required this.upComingMovieModel,
  });

  @override
  List<Object?> get props => [
    trendingMoviesModel,
    popularMoviesModel,
    topRatedMovieModel,
    nowPlayingMovieModel,
    upComingMovieModel,
  ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

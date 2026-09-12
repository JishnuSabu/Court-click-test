import 'package:bloc_test/bloc_test.dart';
import 'package:court_click_task/bloc/home/home_bloc.dart';
import 'package:court_click_task/bloc/home/home_event.dart';
import 'package:court_click_task/bloc/home/home_state.dart';
import 'package:court_click_task/models/now_playing_movie_model.dart' as np;
import 'package:court_click_task/models/popular_movies_model.dart' as pop;
import 'package:court_click_task/models/top_rated_movie_model.dart' as tr;
import 'package:court_click_task/models/trending_movies_model.dart';
import 'package:court_click_task/models/up_coming_movie_model.dart' as up;
import 'package:court_click_task/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late HomeBloc homeBloc;
  late MockApiService mockApiService;

  final tMovie = Results(
    id: 1,
    title: 'Test Movie',
    overview: 'Test Overview',
    posterPath: '/test.jpg',
  );

  final tTrendingModel = TrendingMoviesModel(
    page: 1,
    results: [tMovie],
    totalPages: 1,
    totalResults: 1,
  );

  final tPopularModel = pop.PopularMoviesModel(
    page: 1,
    results: [pop.Results(id: 1, title: 'Test Movie', overview: 'Test Overview', posterPath: '/test.jpg')],
    totalPages: 1,
    totalResults: 1,
  );

  final tTopRatedModel = tr.TopRatedMovieModel(
    page: 1,
    results: [tr.Results(id: 1, title: 'Test Movie', overview: 'Test Overview', posterPath: '/test.jpg')],
    totalPages: 1,
    totalResults: 1,
  );

  final tNowPlayingModel = np.NowPlayingMovieModel(
    page: 1,
    results: [np.Results(id: 1, title: 'Test Movie', overview: 'Test Overview', posterPath: '/test.jpg')],
    totalPages: 1,
    totalResults: 1,
  );

  final tUpcomingModel = up.UpComingMovieModel(
    page: 1,
    results: [up.Results(id: 1, title: 'Test Movie', overview: 'Test Overview', posterPath: '/test.jpg')],
    totalPages: 1,
    totalResults: 1,
  );

  setUp(() {
    mockApiService = MockApiService();
    homeBloc = HomeBloc(apiService: mockApiService);
  });

  tearDown(() {
    homeBloc.close();
  });

  test('initial state should be HomeInitial', () {
    expect(homeBloc.state, equals(const HomeInitial()));
  });

  blocTest<HomeBloc, HomeState>(
    'emits [HomeLoading, HomeLoaded] when FetchHomeMovies succeeds',
    build: () {
      when(() => mockApiService.getTrendingMovies())
          .thenAnswer((_) async => tTrendingModel);
      when(() => mockApiService.getPopularMovies())
          .thenAnswer((_) async => tPopularModel);
      when(() => mockApiService.getTopRatedMovies())
          .thenAnswer((_) async => tTopRatedModel);
      when(() => mockApiService.getNowPlayingMovies())
          .thenAnswer((_) async => tNowPlayingModel);
      when(() => mockApiService.getUpcomingMovies())
          .thenAnswer((_) async => tUpcomingModel);
      return homeBloc;
    },
    act: (bloc) => bloc.add(const FetchHomeMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const HomeLoading(),
      HomeLoaded(
        trendingMoviesModel: tTrendingModel,
        popularMoviesModel: tPopularModel,
        topRatedMovieModel: tTopRatedModel,
        nowPlayingMovieModel: tNowPlayingModel,
        upComingMovieModel: tUpcomingModel,
      ),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'emits [HomeLoading, HomeError] when FetchHomeMovies fails',
    build: () {
      when(() => mockApiService.getTrendingMovies())
          .thenThrow(Exception('Server error'));
      when(() => mockApiService.getPopularMovies())
          .thenThrow(Exception('Server error'));
      when(() => mockApiService.getTopRatedMovies())
          .thenThrow(Exception('Server error'));
      when(() => mockApiService.getNowPlayingMovies())
          .thenThrow(Exception('Server error'));
      when(() => mockApiService.getUpcomingMovies())
          .thenThrow(Exception('Server error'));
      return homeBloc;
    },
    act: (bloc) => bloc.add(const FetchHomeMovies()),
    expect: () => [
      const HomeLoading(),
      const HomeError('Unexpected error occurred: Exception: Server error'),
    ],
  );
}

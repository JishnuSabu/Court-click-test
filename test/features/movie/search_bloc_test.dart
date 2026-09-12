import 'package:bloc_test/bloc_test.dart';
import 'package:court_click_task/bloc/search/search_bloc.dart';
import 'package:court_click_task/bloc/search/search_event.dart';
import 'package:court_click_task/bloc/search/search_state.dart';
import 'package:court_click_task/models/popular_movies_model.dart' as pop;
import 'package:court_click_task/models/trending_movies_model.dart';
import 'package:court_click_task/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late SearchBloc searchBloc;
  late MockApiService mockApiService;

  final tMovie = Results(
    id: 1,
    title: 'Inception',
    overview: 'Dream within a dream',
  );

  final tMoviesModel = TrendingMoviesModel(
    page: 1,
    results: [tMovie],
    totalPages: 1,
    totalResults: 1,
  );

  final tPopularModel = pop.PopularMoviesModel(
    page: 1,
    results: [
      pop.Results(
        id: 1,
        title: 'Inception',
        overview: 'Dream within a dream',
      ),
    ],
    totalPages: 1,
    totalResults: 1,
  );

  setUp(() {
    mockApiService = MockApiService();
    searchBloc = SearchBloc(apiService: mockApiService);
  });

  tearDown(() {
    searchBloc.close();
  });

  test('initial state should be SearchInitial', () {
    expect(searchBloc.state, equals(const SearchInitial()));
  });

  blocTest<SearchBloc, SearchState>(
    'emits [SearchInitial] with popular movies when FetchTopSearches succeeds',
    build: () {
      when(() => mockApiService.getPopularMovies())
          .thenAnswer((_) async => tPopularModel);
      return searchBloc;
    },
    act: (bloc) => bloc.add(const FetchTopSearches()),
    expect: () => [
      SearchInitial(topSearches: [tMovie]),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'emits [SearchLoading, SearchLoaded] when SearchQueryChanged succeeds',
    build: () {
      when(() => mockApiService.searchMovies('Inception'))
          .thenAnswer((_) async => tMoviesModel);
      return searchBloc;
    },
    act: (bloc) => bloc.add(const SearchQueryChanged('Inception')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const SearchLoading(),
      SearchLoaded(query: 'Inception', movies: [tMovie]),
    ],
  );
}

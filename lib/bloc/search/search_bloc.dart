import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/network/api_handle.dart';
import '../../core/network/api_status.dart';
import '../../models/popular_movies_model.dart' show PopularMoviesModel;
import '../../models/trending_movies_model.dart' show TrendingMoviesModel, Results;
import '../../services/api_service.dart';
import 'search_event.dart';
import 'search_state.dart';

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> with ApiHandler {
  final ApiService apiService;

  SearchBloc({required this.apiService}) : super(const SearchInitial()) {
    on<FetchTopSearches>(_onFetchTopSearches);
    on<ClearSearch>(_onClearSearch);
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounce(const Duration(milliseconds: 400)),
    );
  }

  Future<void> _onFetchTopSearches(
    FetchTopSearches event,
    Emitter<SearchState> emit,
  ) async {
    final response = await handleApi<PopularMoviesModel>(
      () async => await apiService.getPopularMovies(),
    );
    if (response.status == ApiStatus.success && response.data?.results != null) {
      final movies = response.data!.results!
          .map((e) => Results.fromJson(e.toJson()))
          .toList();
      emit(SearchInitial(topSearches: movies));
    } else {
      emit(const SearchInitial(topSearches: []));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    if (state is SearchInitial) return;
    add(const FetchTopSearches());
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      add(const FetchTopSearches());
      return;
    }

    emit(const SearchLoading());

    final response = await handleApi<TrendingMoviesModel>(
      () async => await apiService.searchMovies(query),
    );

    if (response.status == ApiStatus.success && response.data != null) {
      final movies = response.data?.results ?? [];
      if (movies.isEmpty) {
        emit(SearchEmpty(query));
      } else {
        emit(SearchLoaded(query: query, movies: movies));
      }
    } else {
      emit(SearchError(response.message ?? 'Error searching movies'));
    }
  }
}

import 'package:equatable/equatable.dart';
import '../../models/trending_movies_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  final List<Results> topSearches;

  const SearchInitial({this.topSearches = const []});

  @override
  List<Object?> get props => [topSearches];
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final String query;
  final List<Results> movies;

  const SearchLoaded({required this.query, required this.movies});

  @override
  List<Object?> get props => [query, movies];
}

class SearchEmpty extends SearchState {
  final String query;

  const SearchEmpty(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

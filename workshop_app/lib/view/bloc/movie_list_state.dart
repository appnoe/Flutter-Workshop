part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListState {}

class MovieListInitial extends MovieListState {}
class MovieListLoadingStarted extends MovieListState {}

class MovieListLoadingFailed extends MovieListState {}
class MovieListLoadingSucceded extends MovieListState {
  final List<TVMazeSearchResult> movieList;

  MovieListLoadingSucceded({required this.movieList});
}

class MovieListLoadingSuccededWithEmptyList extends MovieListState {}
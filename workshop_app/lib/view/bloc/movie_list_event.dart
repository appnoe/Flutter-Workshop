part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListEvent {}
class MovieListRequested extends MovieListEvent {
  final String searchText;

  MovieListRequested(this.searchText);
}
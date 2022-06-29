import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workshop_app/model/tvmazesearchresult.dart';

import '../../api/api.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(MovieListInitial()) {
    on<MovieListEvent>((event, emit) async {
      print(event);
      emit(MovieListLoadingStarted());

      if (event is MovieListRequested) {
        final result = await Api().fetchShow(event.searchText);

        if (result != null) {
          if (result.isEmpty) {
            emit(MovieListLoadingSuccededWithEmptyList());
          } else {
            emit(MovieListLoadingSucceded(movieList: result));
          }
        } else {
          emit(MovieListLoadingFailed());
        }
      }
    });
  }
}

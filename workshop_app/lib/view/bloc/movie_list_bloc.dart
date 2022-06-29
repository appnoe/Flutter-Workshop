import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workshop_app/model/tvmazesearchresult.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(MovieListInitial()) {
    on<MovieListEvent>((event, emit) {
      emit(MovieListLoadingStarted());

      if (event is MovieListRequested) {
        // api laden
        // daten aufbereiten
        // ..

        emit(MovieListLoadingFailed());
      }

    });
  }
}

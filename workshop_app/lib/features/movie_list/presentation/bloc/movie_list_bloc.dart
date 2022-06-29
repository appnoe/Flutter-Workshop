import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workshop_app/features/movie_list/usecase/get_movie_list.dart';
import 'package:workshop_app/model/tvmazesearchresult.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetMovieList _getMovieList;

  MovieListBloc(this._getMovieList) : super(MovieListInitial()) {
    on<MovieListEvent>(
      (event, emit) async {
        print(event);
        emit(MovieListLoadingStarted());

        if (event is MovieListRequested) {
          try {
            final result = await _getMovieList.fetchData(event.searchText);

            if (result != null) {
              if (result.isEmpty) {
                emit(MovieListLoadingSuccededWithEmptyList());
              } else {
                emit(MovieListLoadingSucceded(movieList: result));
              }
            }
          } catch (e) {
            emit(MovieListLoadingFailed());
          }
        }
      },
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:workshop_app/features/movie_list/presentation/bloc/movie_list_bloc.dart';
import 'package:workshop_app/features/movie_list/usecase/get_movie_list.dart';

import 'common/api/api.dart';

Future initializeIoC() async {
  await registerWrapper();
  await registerUseCases();
  await registerBlocs();
}

Future registerWrapper() async {
  singleton(() => Api());
}

Future registerUseCases() async {
  singleton(() => GetMovieList(get<Api>()));
}

Future registerBlocs() async {
  singleton(() => MovieListBloc(getMovieList: get<GetMovieList>()));
}

T get<T extends Object>({dynamic param}) {
  return getFunc<T>(param: param);
}

T Function<T extends Object>({dynamic param}) getFunc = _get;

T _get<T extends Object>({dynamic param}) {
  return GetIt.instance.get<T>(param1: param);
}

void singleton<T extends Object>(T Function() constructor, [void singleton]) {
  GetIt.instance.registerLazySingleton<T>(constructor);
}

void factory<T extends Object>(T Function() constructor) {
  GetIt.instance.registerFactory<T>(constructor);
}

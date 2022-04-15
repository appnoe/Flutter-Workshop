import 'package:bloc_to_bloc/featureA/bloc/featurea_bloc.dart';
import 'package:get_it/get_it.dart';

import 'featureB/bloc/featureb_bloc.dart';

Future<void> initializeIoC() async {
  await _registerBlocs();
}

Future _registerBlocs() async {
  singleton<FeaturebBloc>(() => FeaturebBloc());
  singleton<FeatureaBloc>(() => FeatureaBloc(get<FeaturebBloc>()));
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

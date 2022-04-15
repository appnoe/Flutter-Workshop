import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../featureB/bloc/featureb_bloc.dart';

part 'featurea_event.dart';
part 'featurea_state.dart';

class FeatureaBloc extends Bloc<FeatureaEvent, FeatureaState> {
  final FeaturebBloc featurebBloc;
  StreamSubscription? _featureBStream;

  FeatureaBloc(this.featurebBloc) : super(FeatureaInitial()) {

    _featureBStream = featurebBloc.stream.listen((featureBstate) => {
      if (featureBstate is AuthorizationFailed) {
        add(ForceLogout())
      }
    });

    on<FeatureaEvent>((event, emit) {
      if (event is ForceLogout) {
        // SecureStorage -> remove Auth Token
        emit(ForceLogoutInitiated()); // Die UI nimmt ForceLogout über den BlocListener entgegen und navigiert zur Startseite.
      }
    });
  }

  @override
  Future<void> close() async {
    await _featureBStream?.cancel();
    _featureBStream = null;
    return super.close();
  }
}

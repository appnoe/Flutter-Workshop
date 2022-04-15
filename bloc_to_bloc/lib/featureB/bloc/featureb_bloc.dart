import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'featureb_event.dart';
part 'featureb_state.dart';

class FeaturebBloc extends Bloc<FeaturebEvent, FeaturebState> {

  FeaturebBloc() : super(FeaturebInitial()) {

    on<FeaturebEvent>((event, emit) {
      // try {
      //    if (event is APIRequest) throw Unauthorized
      // } on Unauthorized {
      //    emit(AuthorizationFailed()) <---- State muss NICHT in der UI behandelt werden, KANN aber.
      //    
      //    alternativ, ohne Bloc to Bloc:
      //    
      //    get<FeatureaBloc>().add(ForceLogout())
      // } catch (e) {
      //    print(e);
      // }
      //  
    });
  }
}

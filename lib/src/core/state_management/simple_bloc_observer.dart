import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/functions/functions.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    dprint(
      '${bloc.runtimeType} - event: ${transition.event}\n${transition.currentState}\n${transition.nextState}',
      name: 'bloc',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    dprint('${bloc.runtimeType} $error $stackTrace', error: true, name: 'bloc');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    dprint('${bloc.runtimeType} close', name: 'bloc');
    super.onClose(bloc);
  }
}

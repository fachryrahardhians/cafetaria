import 'package:bloc/bloc.dart';

import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<LogoutState> emit) async {
    emit(state.clone());
  }
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';

import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthenticationRepository _authenticationRepository;

  LogoutBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(LogoutStateInit()) {
    on<LogoutEvent>((event, emit) => _logout(emit, event));
  }

  Future<void> _logout(Emitter<LogoutState> emit, LogoutEvent event) async {
    emit(LogoutStateLoading());
    try {
      await _authenticationRepository.signoutGoogle();
      emit(LogoutStateSuccess());
    } catch (e) {
      emit(LogoutStateError(e.toString()));
    }
  }
}

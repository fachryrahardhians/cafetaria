import 'package:authentication_repository/authentication_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthenticationRepository _authenticationRepository;
  final AppSharedPref _appSharedPref;
  LogoutBloc(
      {required AuthenticationRepository authenticationRepository,
      required AppSharedPref appSharedPref})
      : _authenticationRepository = authenticationRepository,
        _appSharedPref = appSharedPref,
        super(LogoutStateInit()) {
    on<LogoutEvent>((event, emit) => _logout(emit, event));
  }

  Future<void> _logout(Emitter<LogoutState> emit, LogoutEvent event) async {
    emit(LogoutStateLoading());
    try {
      await _authenticationRepository.signoutGoogle();
      _appSharedPref.setLogin(false);
      _appSharedPref.setMerchantId("");
      emit(LogoutStateSuccess());
    } catch (e) {
      emit(LogoutStateError(e.toString()));
    }
  }
}

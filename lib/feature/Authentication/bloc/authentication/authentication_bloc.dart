import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final AppSharedPref _appSharedPref;
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository,
      required AppSharedPref appSharedPref
      })
      : _authenticationRepository = authenticationRepository,
        _appSharedPref = appSharedPref,
        super(AuthenticationStateInit()) {
    on<GetGoogleAuthentication>((event, emit) => _signWithGoogle(emit, event));
  }

  Future<void> _signWithGoogle(
      Emitter<AuthenticationState> emit, AuthenticationEvent event) async {
    emit(AuthenticationStateLoading());
    try {
      final result = await _authenticationRepository.signedWithGoogle();
      emit(AuthenticationStateSuccess(result!));
      _appSharedPref.setLogin(true);
      // final User? user =  await _authenticationRepository.getCurrentUser();
    } catch (e) {
      emit(AuthenticationStateError(e.toString()));
    }
  }
}

import 'package:authentication_repository/authentication_repository.dart';
// ignore: depend_on_referenced_packages
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
      required AppSharedPref appSharedPref})
      : _authenticationRepository = authenticationRepository,
        _appSharedPref = appSharedPref,
        super(AuthenticationStateInit()) {
    on<GetGoogleAuthentication>((event, emit) => _signWithGoogle(emit, event));
    on<GetPasswordLogin>((event, emit) => _signinWithPassword(emit, event));
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

  Future<void> _signinWithPassword(
      Emitter<AuthenticationState> emit, GetPasswordLogin event) async {
    emit(AuthenticationStateLoading());
    try {
      final result = await _authenticationRepository.signedWithEmailAndPassword(
          event.email, event.password);
      emit(AuthenticationStateSuccess(result!));
      _appSharedPref.setAdmin(true);

      // final User? user =  await _authenticationRepository.getCurrentUser();
    } catch (e) {
      emit(AuthenticationStateError(e.toString()));
    }
  }
}

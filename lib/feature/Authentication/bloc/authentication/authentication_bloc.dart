import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  AuthenticationBloc({required AuthenticationRepository
  authenticationRepository}) : _authenticationRepository =
      authenticationRepository,super
      (AuthenticationStateInit()) {
    // on<InitEvent>(_init);
    on<GetGoogleAuthentication>((event,emit)=>_signWithGoogle(emit, event));
  }

  // void _init(InitEvent event, Emitter<AuthenticationState> emit) async {
  //   emit(state.clone());
  // }

  Future<void> _signWithGoogle(Emitter<AuthenticationState> emit,
      AuthenticationEvent event,) async {
    emit(AuthenticationStateLoading());
    try{
      final result = await _authenticationRepository.signedWithGoogle();
      emit(AuthenticationStateSuccess(result!));
    }catch(e){
      emit(AuthenticationStateError(e.toString()));
    }
  }


}

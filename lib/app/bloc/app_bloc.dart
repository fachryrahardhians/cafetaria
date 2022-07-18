import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AppState.unauthenticated()) {
    _userSubscription = _authenticationRepository.user.listen(
      _onUserChanged,
      onError: (e) {
        add(const AppUserChanged());
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User?>? _userSubscription;

  void _onUserChanged(User? user) {
    if (user != null) {
      add(AppUserChanged(user: user));
    } else {
      add(const AppUserChanged());
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/app.dart';
import 'package:cafetaria/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  bootstrap(
    (
      firebaseAuth,
      firebaseStore,
      sharedpreference,
    ) async {
      //
      final _authenticationRepository = AuthenticationRepository(firebaseAuth);
      // Initialize Firebase
      await Firebase.initializeApp();

      return App(
        authenticationRepository: _authenticationRepository,
      );
    },
  );
}

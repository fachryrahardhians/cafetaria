import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/app.dart';
import 'package:cafetaria/bootstrap.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:penjual_repository/penjual_repository.dart';

void main() async {
  bootstrap(
    (
      firebaseAuth,
      firebaseStore,
      sharedpreference,
    ) async {
      //
      final _authenticationRepository = AuthenticationRepository(firebaseAuth);
      final _menuRepository = MenuRepository(firestore: firebaseStore);

      final fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);

      // Initialize Firebase

      return App(
        authenticationRepository: _authenticationRepository,
        menuRepository: _menuRepository,
      );
    },
  );
}

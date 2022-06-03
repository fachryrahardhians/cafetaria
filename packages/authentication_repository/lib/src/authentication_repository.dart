import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

/// author: @burhanwakhid
class AuthenticationRepository {
  const AuthenticationRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  /// sign user anonymously
  Future<void> signedAnonymous() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on Exception catch (error, stacktrace) {
      throw AuthenticationException(error, stacktrace);
    }
  }

  /// sign user with email and password
  /// [email] and [password] must not be null
  Future<void> signedWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (error, stacktrace) {
      throw AuthenticationException(error, stacktrace);
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// sign user with gmail
  /// [email] and [password] must not be null
  Future<GoogleSignInAccount?> signedWithGoogle() async {
    try {
      final data = await _googleSignIn.signIn();
      print(data!.photoUrl);
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await data.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      return data;
    } on Exception catch (error, stacktrace) {
      print(error);
      throw AuthenticationException(error, stacktrace);
    }
  }
}

/// {@template authentication_exception}
/// Exception for authentication repository failures.
/// {@endtemplate}
class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error, this.stackTrace);

  /// The error that was caught.
  final Object error;

  /// The Stacktrace associated with the [error].
  final StackTrace stackTrace;
}

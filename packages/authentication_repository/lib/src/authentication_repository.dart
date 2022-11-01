import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

/// author: @burhanwakhid
class AuthenticationRepository {
  AuthenticationRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  final String fcm = "fcmTokenOy";
  Future<bool> saveFcmToken(String token) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(fcm, token);
  }

  Future<String> getFcmToken() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(fcm) ?? "";
  }

  /// sign out google
  Future<void> signoutGoogle() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } on Exception catch (error, stacktrace) {
      throw AuthenticationException(error, stacktrace);
    }
  }

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
  Future<UserCredential?> signedWithGoogle() async {
    try {
      final data = await _googleSignIn.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await data!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await _firebaseAuth.signInWithCredential(credential);
    } on Exception catch (error, stacktrace) {
      throw AuthenticationException(error, stacktrace);
    }
  }

  Future<UserCredential> addLinkedEmail(
      {required String email, required String password}) async {
    try {
      final credential =
          EmailAuthProvider.credential(email: email, password: password);
      final userCredential = await FirebaseAuth.instance.currentUser!
          .linkWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          break;
        case "invalid-credential":
          break;
        case "credential-already-in-use":
          break;
        // See the API reference for the full list of error codes.
        default:
      }
      throw Exception(e);
    }
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().asyncMap(_handleAuthStateChanged);
  }

  Future<User?> _handleAuthStateChanged(User? auth) async {
    return auth;
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

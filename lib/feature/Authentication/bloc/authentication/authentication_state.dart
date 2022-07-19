import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationStateSuccess extends AuthenticationState {
  final GoogleSignInAccount googleSignIn;
  AuthenticationStateSuccess(this.googleSignIn);
  @override
  List<Object?> get props => [googleSignIn];
}

class AuthenticationStateLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateError extends AuthenticationState {
  final String error;
  AuthenticationStateError(this.error);
  @override
  List<Object?> get props => [error];
}

class AuthenticationStateInit extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

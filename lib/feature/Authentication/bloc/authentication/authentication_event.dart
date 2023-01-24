import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

// class InitEvent extends AuthenticationEvent {}

class GetGoogleAuthentication extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class GetPasswordLogin extends AuthenticationEvent {
  final String email;
  final String password;
  GetPasswordLogin(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

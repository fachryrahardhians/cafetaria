import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

// class InitEvent extends AuthenticationEvent {}

class GetGoogleAuthentication extends AuthenticationEvent{
  @override
  List<Object?> get props => [];
}
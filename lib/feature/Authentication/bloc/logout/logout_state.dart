import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable{}

class LogoutStateSuccess extends LogoutState{
  @override
  List<Object?> get props => [];
}
class LogoutStateInit extends LogoutState{
  @override
  List<Object?> get props => [];
}
class LogoutStateError extends LogoutState{
  final String error;
  LogoutStateError(this.error);
  @override
  List<Object?> get props => [error];
}
class LogoutStateLoading extends LogoutState{
  @override
  List<Object?> get props => [];
}

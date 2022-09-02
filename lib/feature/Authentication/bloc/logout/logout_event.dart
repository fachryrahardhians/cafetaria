import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {}

class DoLogout extends LogoutEvent {
  @override
  List<Object?> get props => [];
}

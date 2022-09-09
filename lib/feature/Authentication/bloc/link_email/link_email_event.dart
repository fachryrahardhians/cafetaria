import 'package:equatable/equatable.dart';

abstract class LinkEmailEvent extends Equatable{}

class DoEmailLink extends LinkEmailEvent {
  final String email;
  final String password;

  DoEmailLink({required this.email,required this.password});
  @override
  List<Object?> get props => [email,password];
}
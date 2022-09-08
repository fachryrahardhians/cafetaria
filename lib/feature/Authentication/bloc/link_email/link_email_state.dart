import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LinkEmailState extends Equatable {}

class LinkEmailInit extends LinkEmailState {
  @override
  List<Object?> get props => [];
}

class LinkEmailLoading extends LinkEmailState {
  @override
  List<Object?> get props => [];
}

class LinkEmailSuccess extends LinkEmailState {
  final UserCredential credential;

  LinkEmailSuccess({required this.credential});

  @override
  List<Object?> get props => [credential];
}

class LinkEmailError extends LinkEmailState {
  final String error;

  LinkEmailError({required this.error});

  @override
  List<Object?> get props => [];
}

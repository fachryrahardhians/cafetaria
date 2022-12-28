part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetListUser extends UserEvent {
  const GetListUser();

  @override
  List<Object> get props => [];
}

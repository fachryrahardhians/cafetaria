part of 'user_bloc.dart';

enum UserStatus { initial, loading, success, failure }

class UserState extends Equatable {
  const UserState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final UserStatus status;
  final List<UserModelChat>? items;
  final String? errorMessage;

  const UserState.initial() : this.__(status: UserStatus.initial);

  const UserState.loading() : this.__(status: UserStatus.loading);

  const UserState.success(List<UserModelChat> items)
      : this.__(
          status: UserStatus.success,
          items: items,
        );

  const UserState.failure(String errorMessage)
      : this.__(
          status: UserStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  UserState copyWith({
    UserStatus? status,
    List<UserModelChat>? items,
    String? errorMessage,
  }) {
    return UserState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

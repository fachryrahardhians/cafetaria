part of 'admin_kawasan_bloc.dart';

enum AdminKawasanStatus { initial, loading, success, failure }

class AdminKawasanState extends Equatable {
  const AdminKawasanState.__(
      {this.errorMessage, this.items, required this.status});

  final AdminKawasanStatus status;
  final UserAdmin? items;
  final String? errorMessage;

  const AdminKawasanState.initial()
      : this.__(status: AdminKawasanStatus.initial);

  const AdminKawasanState.loading()
      : this.__(status: AdminKawasanStatus.loading);

  const AdminKawasanState.success(UserAdmin items)
      : this.__(
          status: AdminKawasanStatus.success,
          items: items,
        );

  const AdminKawasanState.failure(String errorMessage)
      : this.__(
          status: AdminKawasanStatus.failure,
          errorMessage: errorMessage,
        );
  @override
  List<Object?> get props => [status, items, errorMessage];
}

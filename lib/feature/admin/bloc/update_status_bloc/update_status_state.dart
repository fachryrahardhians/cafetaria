part of 'update_status_bloc.dart';

class UpdateStatusState extends Equatable {
  const UpdateStatusState({
    this.idKawasan = "",
    this.stat = "",
    this.status = FormzStatus.pure,
    this.message = "",
  });
  final FormzStatus status;
  final String idKawasan;
  final String message;
  final String stat;
  @override
  List<Object> get props => [idKawasan, stat, status, message];
  UpdateStatusState copyWith(
      {
      // bool? status,
      String? message,
      FormzStatus? status,
      String? idKawasan,
      String? stat}) {
    return UpdateStatusState(
        idKawasan: idKawasan ?? this.idKawasan,
        stat: stat ?? this.stat,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}

part of 'update_status_bloc.dart';

class UpdateStatusEvent extends Equatable {
  const UpdateStatusEvent();

  @override
  List<Object> get props => [];
}

class UpdateStatus extends UpdateStatusEvent {
  final String idKawasan;
  final String status;
  final String idUser;
  final String kawasan;

  const UpdateStatus(this.idKawasan, this.status, this.idUser, this.kawasan);

  @override
  List<Object> get props => [idKawasan, status];
}

part of 'admin_kawasan_bloc.dart';

abstract class AdminKawasanEvent extends Equatable {
  const AdminKawasanEvent();

  @override
  List<Object> get props => [];
}

class GetAdmin extends AdminKawasanEvent {
  final String userId;
  const GetAdmin(this.userId);
  @override
  List<Object> get props => [];
}

part of 'pilih_kawasan_bloc.dart';

abstract class PilihKawasanEvent extends Equatable {
  const PilihKawasanEvent();

  @override
  List<Object> get props => [];
}

class GetPilihKawasan extends PilihKawasanEvent {
  const GetPilihKawasan();
  @override
  List<Object> get props => [];
}

class GetDistanceKawasan extends PilihKawasanEvent {
  final String long;
  final String lat;
  const GetDistanceKawasan({required this.long, required this.lat});
  @override
  List<Object> get props => [];
}

class KawasanChange extends PilihKawasanEvent {
  final String kawasan;

  const KawasanChange(this.kawasan);

  @override
  List<Object> get props => [kawasan];
}

class UpdateKawasan extends PilihKawasanEvent {
  final String idUser;
  const UpdateKawasan(this.idUser);

  @override
  List<Object> get props => [idUser];
}

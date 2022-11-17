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

class KawasanChange extends PilihKawasanEvent {
  final String kawasan;

  const KawasanChange(this.kawasan);

  @override
  List<Object> get props => [kawasan];
}

part of 'edit_kawasan_bloc.dart';

abstract class EditKawasanEvent extends Equatable {
  const EditKawasanEvent();

  @override
  List<Object> get props => [];
}

class DeleteKawasan extends EditKawasanEvent {
  final String idKawasan;

  const DeleteKawasan(
    this.idKawasan,
  );

  @override
  List<Object> get props => [
        idKawasan,
      ];
}

class EditKawasanChange extends EditKawasanEvent {
  final String idKawasan;
  final String name;

  const EditKawasanChange(this.idKawasan, this.name);

  @override
  List<Object> get props => [idKawasan, name];
}

class NamaKawasanChange extends EditKawasanEvent {
  final String name;

  const NamaKawasanChange(this.name);

  @override
  List<Object> get props => [name];
}

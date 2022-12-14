part of 'edit_kawasan_bloc.dart';

class EditKawasanState extends Equatable {
  const EditKawasanState({
    this.idKawasan = "",
    this.name = "",
    this.status = FormzStatus.pure,
    this.message = "",
  });
  final FormzStatus status;
  final String idKawasan;
  final String message;
  final String name;
  @override
  List<Object> get props => [status, idKawasan, message, name];
  EditKawasanState copyWith(
      {
      // bool? status,
      String? message,
      FormzStatus? status,
      String? idKawasan,
      String? name}) {
    return EditKawasanState(
        idKawasan: idKawasan ?? this.idKawasan,
        name: name ?? this.name,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}

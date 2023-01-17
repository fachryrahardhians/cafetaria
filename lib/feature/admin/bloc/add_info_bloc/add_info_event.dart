part of 'add_info_bloc.dart';

abstract class AddInfoEvent extends Equatable {
  const AddInfoEvent();

  @override
  List<Object> get props => [];
}

class AddInfo extends AddInfoEvent {
  final String judul;
  final String terbit;
  final String kadarluasa;
  final String tipe;
  final String statusInfo;
  final String body;
  final String imageUri;
  final String kawasanId;

  const AddInfo(
      {this.body = "",
      this.imageUri = "",
      this.judul = "",
      this.kadarluasa = "",
      this.statusInfo = "",
      this.terbit = "",
      this.tipe = "",
      this.kawasanId = ""});

  @override
  List<Object> get props => [];
}

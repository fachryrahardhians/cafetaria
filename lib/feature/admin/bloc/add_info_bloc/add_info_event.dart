// ignore_for_file: must_be_immutable

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
  // ignore: prefer_typing_uninitialized_variables
  var body;
  final String imageUri;
  final String kawasanId;

  AddInfo(
      {this.body,
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

class Updateinfo extends AddInfoEvent {
  final String judul;
  final String terbit;
  final String kadarluasa;
  final String tipe;
  final String statusInfo;
  // ignore: prefer_typing_uninitialized_variables
  var body;
  final String imageUri;
  final String kawasanId;
  final String infoId;

  Updateinfo(
      {this.body,
      this.imageUri = "",
      this.judul = "",
      this.kadarluasa = "",
      this.statusInfo = "",
      this.terbit = "",
      this.tipe = "",
      this.kawasanId = "",
      this.infoId = ""});

  @override
  List<Object> get props => [];
}

class DeleteInfo extends AddInfoEvent {
  final InfoModel infoModel;

  const DeleteInfo(this.infoModel);

  @override
  List<Object> get props => [];
}

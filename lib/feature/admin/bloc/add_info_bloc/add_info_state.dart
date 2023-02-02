// ignore_for_file: must_be_immutable

part of 'add_info_bloc.dart';

class AddInfoState extends Equatable {
   AddInfoState(
      {this.status = FormzStatus.pure,
      this.body ,
      this.imageUri = "",
      this.judul = "",
      this.kadarluasa = "",
      this.statusInfo = "",
      this.terbit = "",
      this.tipe = "",
      this.kawasanId = ""});
  final FormzStatus status;
  final String judul;
  final String terbit;
  final String kadarluasa;
  final String tipe;
  final String statusInfo;
  // ignore: prefer_typing_uninitialized_variables
  var body;
  final String imageUri;
  final String kawasanId;
  @override
  List<Object> get props => [
        status,
        judul,
        terbit,
        kadarluasa,
        tipe,
        statusInfo,
        body,
        imageUri,
        kawasanId
      ];
  AddInfoState copyWith(
      {
      // bool? status,
      FormzStatus? status,
      String? judul,
      String? terbit,
      String? kadarluasa,
      String? tipe,
      String? statusInfo,
      var body,
      String? imageUri,
      String? kawasanId}) {
    return AddInfoState(
        status: status ?? this.status,
        judul: judul ?? this.judul,
        terbit: terbit ?? this.terbit,
        kadarluasa: kadarluasa ?? this.kadarluasa,
        tipe: tipe ?? this.tipe,
        body: body ?? this.body,
        imageUri: imageUri ?? this.imageUri,
        statusInfo: statusInfo ?? this.statusInfo,
        kawasanId: kawasanId ?? this.kawasanId);
  }
}

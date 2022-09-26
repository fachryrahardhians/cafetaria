part of 'opsi_menu_bloc.dart';

class OpsiMenuState extends Equatable {
  const OpsiMenuState(
      {this.status = FormzStatus.pure,
      this.opsiInput = const OpsiInput.pure(),
      // this.opsiPilihanInput = const OpsiPilihanInput.pure(),
      // this.opsiHarga = const OpsiHarga.pure(),
      this.option = const <Option>[],
      this.banyakOpsi = false,
      this.wajibMemilih = false});
  final FormzStatus status;
  final OpsiInput opsiInput;
  // final OpsiPilihanInput opsiPilihanInput;
  // final OpsiHarga opsiHarga;
  final List<Option> option;
  final bool wajibMemilih;
  final bool banyakOpsi;
  @override
  List<Object> get props => [
        status,
        // opsiHarga,
        opsiInput,
        //opsiPilihanInput,
        option,
        wajibMemilih,
        banyakOpsi
      ];
  OpsiMenuState copyWith({
    FormzStatus? status,
    OpsiInput? opsiInput,
    // OpsiPilihanInput? opsiPilihanInput,
    // OpsiHarga? opsiHarga,
    List<Option>? option,
    bool? wajibMemilih,
    bool? banyakOpsi,
  }) {
    return OpsiMenuState(
        banyakOpsi: banyakOpsi ?? this.banyakOpsi,
        //opsiHarga: opsiHarga ?? this.opsiHarga,
        opsiInput: opsiInput ?? this.opsiInput,
        //opsiPilihanInput: opsiPilihanInput ?? this.opsiPilihanInput,
        option: option ?? this.option,
        status: status ?? this.status,
        wajibMemilih: wajibMemilih ?? this.wajibMemilih);
  }
}

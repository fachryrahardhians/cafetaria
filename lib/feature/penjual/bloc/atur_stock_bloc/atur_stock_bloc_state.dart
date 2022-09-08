part of 'atur_stock_bloc_bloc.dart';

class AturStockBlocState extends Equatable {
  const AturStockBlocState({
    this.status = FormzStatus.pure,
    this.message = "",
    this.tipeRestok = const RestokTipeInput.pure(),
    this.stokInput = const StokInput.pure(),
    this.restok = false,
    this.tersedia = true,
    this.timeReset = const TimeInput.pure(),
  });
  final FormzStatus status;
  final StokInput stokInput;
  // final String tipeRestok;
  final TimeInput timeReset;
  final RestokTipeInput tipeRestok;
  final bool restok;
  final bool tersedia;
  //final bool status;
  final String message;
  //list get props untuk mengambil variabel yang ingin dibaca di equatable dan copywith jika tidak dipanggil data tidak akan kebaca dan tidak akan berubah disaat dipanggil di class lain
  @override
  List<Object?> get props =>
      [status, stokInput, restok, tersedia, timeReset, tipeRestok];

  AturStockBlocState copyWith(
      {
      // bool? status,
      String? message,
      FormzStatus? status,
      TimeInput? timeReset,
      StokInput? stokInput,
      RestokTipeInput? tipeRestok,
      //String? tipeRestok,
      bool? restok,
      bool? tersedia}) {
    return AturStockBlocState(
        message: message ?? this.message,
        status: status ?? this.status,
        restok: restok ?? this.restok,
        tipeRestok: tipeRestok ?? this.tipeRestok,
        timeReset: timeReset ?? this.timeReset,
        stokInput: stokInput ?? this.stokInput,
        tersedia: tersedia ?? this.tersedia);
  }
}

part of 'pilih_kawasan_bloc.dart';

enum PilihKawasanStatus { initial, loading, success, failure }

class PilihKawasanState extends Equatable {
  const PilihKawasanState.__(
      {required this.status, this.items, this.errorMessage, this.idkawasan});

  final PilihKawasanStatus status;
  final List<PilihKawasanModel>? items;
  final String? errorMessage;
  final String? idkawasan;

  const PilihKawasanState.initial()
      : this.__(status: PilihKawasanStatus.initial);

  const PilihKawasanState.loading()
      : this.__(status: PilihKawasanStatus.loading);

  const PilihKawasanState.success(List<PilihKawasanModel> items)
      : this.__(
          status: PilihKawasanStatus.success,
          items: items,
        );

  const PilihKawasanState.failure(String errorMessage)
      : this.__(
          status: PilihKawasanStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage, idkawasan];

  PilihKawasanState copyWith({
    PilihKawasanStatus? status,
    List<PilihKawasanModel>? items,
    String? errorMessage,
    String? idkawasan,
  }) {
    return PilihKawasanState.__(
        status: status ?? this.status,
        items: items ?? this.items,
        errorMessage: errorMessage ?? this.errorMessage,
        idkawasan: idkawasan ?? this.idkawasan);
  }
}

part of 'opsi_menu_makanan_bloc.dart';

enum OpsiMenuMakananStatus { initial, loading, success, failure }

class OpsiMenuMakananState extends Equatable {
  const OpsiMenuMakananState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });
  final OpsiMenuMakananStatus status;
  final List<OptionMenuModel>? items;
  final String? errorMessage;

  const OpsiMenuMakananState.initial() : this.__(status: OpsiMenuMakananStatus.initial);

  const OpsiMenuMakananState.loading() : this.__(status: OpsiMenuMakananStatus.loading);

  const OpsiMenuMakananState.success(
    List<OptionMenuModel> items,
  ) : this.__(
          status: OpsiMenuMakananStatus.success,
          items: items,
        );
  const OpsiMenuMakananState.failure(
    String errorMessage,
  ) : this.__(
          status: OpsiMenuMakananStatus.failure,
          errorMessage: errorMessage,
        );


  @override
  List<Object?> get props => [items, errorMessage, status];

  OpsiMenuMakananState copyWith({
    List<OptionMenuModel>? items,
    String? errorMessage,
    OpsiMenuMakananStatus? status,
  }) {
    return OpsiMenuMakananState.__(
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}

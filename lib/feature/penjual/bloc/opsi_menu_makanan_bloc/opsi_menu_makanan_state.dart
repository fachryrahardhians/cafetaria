part of 'opsi_menu_makanan_bloc.dart';

enum OpsiMenuMakananStatus { initial, loading, success, failure }

class OpsiMenuMakananState extends Equatable {
  const OpsiMenuMakananState.__({
    this.items,
    this.errorMessage,
    required this.status,
  });

  const OpsiMenuMakananState.initial() : this.__(status: OpsiMenuMakananStatus.initial);

  const OpsiMenuMakananState.loading() : this.__(status: OpsiMenuMakananStatus.loading);

  const OpsiMenuMakananState.success(
    List<Option> items,
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

  final List<Option>? items;
  final String? errorMessage;
  final OpsiMenuMakananStatus status;

  @override
  List<Object?> get props => [items, errorMessage, status];

  OpsiMenuMakananState copyWith({
    List<Option>? items,
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

part of 'opsi_menu_bloc.dart';

enum OpsiMenuStatus { initial, loading, success, failure }

class OpsiMenuState extends Equatable {
  const OpsiMenuState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final OpsiMenuStatus status;
  final List<OptionMenuModel>? items;
  final String? errorMessage;

  const OpsiMenuState.initial() : this.__(status: OpsiMenuStatus.initial);

  const OpsiMenuState.loading() : this.__(status: OpsiMenuStatus.loading);

  const OpsiMenuState.success(List<OptionMenuModel> items)
      : this.__(
          status: OpsiMenuStatus.success,
          items: items,
        );

  const OpsiMenuState.failure(String errorMessage)
      : this.__(
          status: OpsiMenuStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  OpsiMenuState copyWith({
    OpsiMenuStatus? status,
    List<OptionMenuModel>? items,
    String? errorMessage,
  }) {
    return OpsiMenuState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

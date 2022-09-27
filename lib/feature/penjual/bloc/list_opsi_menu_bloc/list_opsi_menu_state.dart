part of 'list_opsi_menu_bloc.dart';

enum ListOpsiMenuStatus { initial, loading, success, failure }

class ListOpsiMenuState extends Equatable {
  const ListOpsiMenuState.__(
      {required this.status, this.items, this.errorMessage});
  final ListOpsiMenuStatus status;
  final List<OptionMenuModel>? items;
  final String? errorMessage;

  const ListOpsiMenuState.initial()
      : this.__(status: ListOpsiMenuStatus.initial);

  const ListOpsiMenuState.loading()
      : this.__(status: ListOpsiMenuStatus.loading);

  const ListOpsiMenuState.success(List<OptionMenuModel> items)
      : this.__(
          status: ListOpsiMenuStatus.success,
          items: items,
        );

  const ListOpsiMenuState.failure(String errorMessage)
      : this.__(
          status: ListOpsiMenuStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];
  ListOpsiMenuState copyWith({
    ListOpsiMenuStatus? status,
    List<OptionMenuModel>? items,
    String? errorMessage,
  }) {
    return ListOpsiMenuState.__(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        items: items ?? this.items);
  }
}

part of 'list_menu_bloc.dart';

enum ListMenuStatus { initial, loading, success, failure }

class ListMenuState extends Equatable {
  const ListMenuState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final ListMenuStatus status;
  final List<MenuModel>? items;
  final String? errorMessage;

  const ListMenuState.initial() : this.__(status: ListMenuStatus.initial);

  const ListMenuState.loading() : this.__(status: ListMenuStatus.loading);

  const ListMenuState.success(List<MenuModel> items)
      : this.__(
          status: ListMenuStatus.success,
          items: items,
        );

  const ListMenuState.failure(String errorMessage)
      : this.__(
          status: ListMenuStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  ListMenuState copyWith({
    ListMenuStatus? status,
    List<MenuModel>? items,
    String? errorMessage,
  }) {
    return ListMenuState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

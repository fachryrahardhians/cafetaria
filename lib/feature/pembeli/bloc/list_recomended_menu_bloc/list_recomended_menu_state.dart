part of 'list_recomended_menu_bloc.dart';

enum ListRecomendedMenuStatus { initial, loading, success, failure }

class ListRecomendedMenuState extends Equatable {
  const ListRecomendedMenuState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final ListRecomendedMenuStatus status;
  final List<MenuModel>? items;
  final String? errorMessage;

  const ListRecomendedMenuState.initial()
      : this.__(status: ListRecomendedMenuStatus.initial);

  const ListRecomendedMenuState.loading()
      : this.__(status: ListRecomendedMenuStatus.loading);

  const ListRecomendedMenuState.success(List<MenuModel> items)
      : this.__(
          status: ListRecomendedMenuStatus.success,
          items: items,
        );

  const ListRecomendedMenuState.failure(String errorMessage)
      : this.__(
          status: ListRecomendedMenuStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  ListRecomendedMenuState copyWith({
    ListRecomendedMenuStatus? status,
    List<MenuModel>? items,
    String? errorMessage,
  }) {
    return ListRecomendedMenuState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

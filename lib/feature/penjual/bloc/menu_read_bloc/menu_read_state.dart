part of 'menu_read_bloc.dart';

enum MenuReadStatus { initial, loading, success, failure }

class MenuReadState extends Equatable {
  const MenuReadState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final MenuReadStatus status;
  final List<MenuRead>? items;
  final String? errorMessage;

  const MenuReadState.initial() : this.__(status: MenuReadStatus.initial);

  const MenuReadState.loading() : this.__(status: MenuReadStatus.loading);

  const MenuReadState.success(List<MenuRead> items)
      : this.__(
          status: MenuReadStatus.success,
          items: items,
        );

  const MenuReadState.failure(String errorMessage)
      : this.__(
          status: MenuReadStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  MenuReadState copyWith({
    MenuReadStatus? status,
    List<MenuRead>? items,
    String? errorMessage,
  }) {
    return MenuReadState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

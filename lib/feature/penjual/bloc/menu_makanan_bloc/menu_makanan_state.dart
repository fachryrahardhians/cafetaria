part of 'menu_makanan_bloc.dart';

enum MenuMakananStatus { initial, loading, success, failure }

class MenuMakananState extends Equatable {
  const MenuMakananState.__({
    this.items,
    this.errorMessage,
    required this.status,
  });

  const MenuMakananState.initial() : this.__(status: MenuMakananStatus.initial);

  const MenuMakananState.loading() : this.__(status: MenuMakananStatus.loading);

  const MenuMakananState.success(
    List<CategoryModel> items,
  ) : this.__(
          status: MenuMakananStatus.success,
          items: items,
        );
  const MenuMakananState.failure(
    String errorMessage,
  ) : this.__(
          status: MenuMakananStatus.failure,
          errorMessage: errorMessage,
        );

  final List<CategoryModel>? items;
  final String? errorMessage;
  final MenuMakananStatus status;

  @override
  List<Object?> get props => [items, errorMessage, status];

  MenuMakananState copyWith({
    List<CategoryModel>? items,
    String? errorMessage,
    MenuMakananStatus? status,
  }) {
    return MenuMakananState.__(
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}

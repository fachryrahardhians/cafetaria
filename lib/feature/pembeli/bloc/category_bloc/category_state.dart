part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  const CategoryState.__({
    this.items,
    this.errorMessage,
    required this.status,
  });

  const CategoryState.initial() : this.__(status: CategoryStatus.initial);

  const CategoryState.loading() : this.__(status: CategoryStatus.loading);

  const CategoryState.success(
    List<CategoryModel> items,
  ) : this.__(
          status: CategoryStatus.success,
          items: items,
        );
  const CategoryState.failure(
    String errorMessage,
  ) : this.__(
          status: CategoryStatus.failure,
          errorMessage: errorMessage,
        );

  final List<CategoryModel>? items;
  final String? errorMessage;
  final CategoryStatus status;

  @override
  List<Object?> get props => [items, errorMessage, status];

  CategoryState copyWith({
    List<CategoryModel>? items,
    String? errorMessage,
    CategoryStatus? status,
  }) {
    return CategoryState.__(
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}

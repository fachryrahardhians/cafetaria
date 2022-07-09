part of 'add_category_bloc.dart';

class AddCategoryState extends Equatable {
  const AddCategoryState({
    this.formzStatus = FormzStatus.pure,
    this.categoryInput = const CategoryInput.pure(),
  });

  final FormzStatus formzStatus;
  final CategoryInput categoryInput;

  @override
  List<Object?> get props => [
        formzStatus,
        categoryInput,
      ];

  AddCategoryState copyWith({
    String? errorMessage,
    FormzStatus? formzStatus,
    CategoryInput? categoryInput,
  }) {
    return AddCategoryState(
      formzStatus: formzStatus ?? this.formzStatus,
      categoryInput: categoryInput ?? this.categoryInput,
    );
  }
}

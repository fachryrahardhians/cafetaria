part of 'add_category_bloc.dart';

class AddCategoryState extends Equatable {
  const AddCategoryState({
    this.formzStatus = FormzStatus.pure,
    this.categoryInput = const CategoryInput.pure(),
    this.counter = 0,
  });

  final FormzStatus formzStatus;
  final CategoryInput categoryInput;

  final int counter;

  @override
  List<Object?> get props => [
        formzStatus,
        categoryInput,
        counter,
      ];

  AddCategoryState copyWith({
    FormzStatus? formzStatus,
    CategoryInput? categoryInput,
    int? counter,
  }) {
    return AddCategoryState(
      formzStatus: formzStatus ?? this.formzStatus,
      categoryInput: categoryInput ?? this.categoryInput,
      counter: counter ?? this.counter,
    );
  }
}

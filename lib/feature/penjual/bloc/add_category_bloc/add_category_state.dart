part of 'add_category_bloc.dart';

class AddCategoryState extends Equatable {
  const AddCategoryState(
      {this.formzStatus = FormzStatus.pure,
      this.categoryInput = const CategoryInput.pure(),
      this.counter = 0,
      this.merchantData = ""});

  final FormzStatus formzStatus;
  final CategoryInput categoryInput;

  final int counter;

  final String merchantData;

  @override
  List<Object?> get props =>
      [formzStatus, categoryInput, counter, merchantData];

  AddCategoryState copyWith(
      {FormzStatus? formzStatus,
      CategoryInput? categoryInput,
      int? counter,
      String? merchantData}) {
    return AddCategoryState(
      formzStatus: formzStatus ?? this.formzStatus,
      categoryInput: categoryInput ?? this.categoryInput,
      counter: counter ?? this.counter,
      merchantData: merchantData ?? this.merchantData,
    );
  }
}

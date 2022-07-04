part of 'add_category_bloc.dart';

abstract class AddCategoryState extends Equatable {
  const AddCategoryState();

  @override
  List<Object> get props => [];
}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryLoading extends AddCategoryState {}

class AddCategorySuccess extends AddCategoryState {}

class AddCategoryFailure extends AddCategoryState {
  final String error;

  const AddCategoryFailure(this.error);

  @override
  List<Object> get props => [error];
}

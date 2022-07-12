part of 'add_category_bloc.dart';

class AddCategoryEvent extends Equatable {
  const AddCategoryEvent();

  @override
  List<Object> get props => [];
}

class SaveCategory extends AddCategoryEvent {
  final String category;
  final String idMerchant;

  const SaveCategory({
    required this.category,
    required this.idMerchant,
  });

  @override
  List<Object> get props => [category, idMerchant];
}

class CategoryChange extends AddCategoryEvent {
  final String name;

  const CategoryChange(this.name);

  @override
  List<Object> get props => [name];
}

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'list_merchant_category_event.dart';
part 'list_merchant_category_state.dart';

class ListMerchantCategoryBloc
    extends Bloc<ListMerchantCategoryEvent, ListMerchantCategoryState> {
  final MenuRepository _menuRepository;

  ListMerchantCategoryBloc({required MenuRepository menuRepository})
      : _menuRepository = menuRepository,
        super(const ListMerchantCategoryState.initial()) {
    on<GetListMerchantCategory>(_getListMerchant);
  }

  Future<void> _getListMerchant(
    GetListMerchantCategory event,
    Emitter<ListMerchantCategoryState> emit,
  ) async {
    emit(const ListMerchantCategoryState.loading());

    try {
      final items =
          await _menuRepository.getMerchantByCategory(event.idMerchant);

      emit(ListMerchantCategoryState.success(items));
    } catch (error) {
      emit(ListMerchantCategoryState.failure(error.toString()));
    }
  }
}

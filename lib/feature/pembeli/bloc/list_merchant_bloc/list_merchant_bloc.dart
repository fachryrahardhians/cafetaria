// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merchant_repository/merchant_repository.dart';

part 'list_merchant_event.dart';
part 'list_merchant_state.dart';

class ListMerchantBloc extends Bloc<ListMerchantEvent, ListMerchantState> {
  final MerchantRepository _merchantRepository;

  ListMerchantBloc({
    required MerchantRepository merchantRepository,
  })  : _merchantRepository = merchantRepository,
        super(const ListMerchantState.initial()) {
    on<GetListMerchant>(_getListMerchant);
  }

  Future<void> _getListMerchant(
    GetListMerchant event,
    Emitter<ListMerchantState> emit,
  ) async {
    emit(const ListMerchantState.loading());

    try {
      final items = await _merchantRepository.getMerchant();

      emit(ListMerchantState.success(items));
    } catch (error) {
      emit(ListMerchantState.failure(error.toString()));
    }
  }
}

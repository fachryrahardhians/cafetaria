// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

part 'list_merchant_login_event.dart';
part 'list_merchant_login_state.dart';

class ListMerchantLoginBloc
    extends Bloc<ListMerchantLoginEvent, ListMerchantLoginState> {
  final MerchantRepository _merchantRepository;
  final AppSharedPref _appsharedPref;

  ListMerchantLoginBloc(
      {required MerchantRepository merchantRepository,
      required AppSharedPref appSharedPref})
      : _merchantRepository = merchantRepository,
        _appsharedPref = appSharedPref,
        super(const ListMerchantLoginState.initial()) {
    on<GetListMerchantLogin>(_getListMerchant);
  }

  Future<void> _getListMerchant(
    GetListMerchantLogin event,
    Emitter<ListMerchantLoginState> emit,
  ) async {
    emit(const ListMerchantLoginState.loading());

    try {
      final latitude = await _appsharedPref.getLat();
      final longitude = await _appsharedPref.getLong();
      final items = await _merchantRepository.getMerchantLogin(
          event.userId, double.parse(longitude!), double.parse(latitude!));

      emit(ListMerchantLoginState.success(items));
    } catch (error) {
      emit(ListMerchantLoginState.failure(error.toString()));
    }
  }
}

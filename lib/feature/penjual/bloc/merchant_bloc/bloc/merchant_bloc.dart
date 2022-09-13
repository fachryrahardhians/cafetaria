import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

part 'merchant_event.dart';
part 'merchant_state.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final MerchantRepository _merchantRepository;
  final AppSharedPref _appSharedPref;
  MerchantBloc(
      {required MerchantRepository merchantRepository,
      required AppSharedPref appSharedPref})
      : _merchantRepository = merchantRepository,
        _appSharedPref = appSharedPref,
        super(const MerchantState.initial()) {
    on<GetMerchant>(_getMerchant);
  }

  Future<void> _getMerchant(
    GetMerchant event,
    Emitter<MerchantState> emit,
  ) async {
    emit(const MerchantState.loading());

    try {
      final items = await _merchantRepository.getMerchantDetail(
        event.idUser,
      );
      String? idMerchant;

      if (idMerchant != null) {
        emit(MerchantState.success(items));
      } else {
        _appSharedPref.setMerchantId(items.merchantId.toString());
        emit(MerchantState.success(items));
      }
    } catch (error) {
      emit(MerchantState.failure(error.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merchant_repository/merchant_repository.dart';

part 'merchant_byId_event.dart';
part 'merchant_byId_state.dart';

class MerchantByIdBloc extends Bloc<MerchantByIdEvent, MerchantByIdState> {
  final MerchantRepository _merchantRepository;

  MerchantByIdBloc({required MerchantRepository merchantRepository})
      : _merchantRepository = merchantRepository,
        super(const MerchantByIdState.initial()) {
    on<GetMerchantById>(_getMerchantById);
  }

  Future<void> _getMerchantById(
    GetMerchantById event,
    Emitter<MerchantByIdState> emit,
  ) async {
    emit(const MerchantByIdState.loading());
    try {
      final items = await _merchantRepository.getMerchantById(event.merchantId);
      emit(MerchantByIdState.success(items[0]));
    } catch (error) {
      emit(MerchantByIdState.failure(error.toString()));
    }
  }
}

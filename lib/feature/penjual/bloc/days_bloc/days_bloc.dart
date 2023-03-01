import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merchant_repository/merchant_repository.dart';

part 'days_event.dart';
part 'days_state.dart';

class DaysBloc extends Bloc<DaysEvent, DaysState> {
  final MerchantRepository _merchantRepository;
  DaysBloc({required MerchantRepository merchantRepository})
      : _merchantRepository = merchantRepository,
        super(const DaysState.initial()) {
    on<GetDays>(_getDays);
  }

  Future<void> _getDays(
    GetDays event,
    Emitter<DaysState> emit,
  ) async {
    emit(const DaysState.loading());

    try {
      final items =
          await _merchantRepository.getrulesDay(merchantId: event.merchantId);
      emit(DaysState.success(items));
    } catch (error) {
      emit(DaysState.failure(error.toString()));
    }
  }
}

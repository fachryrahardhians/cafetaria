import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merchant_repository/merchant_repository.dart';

part 'calender_event.dart';
part 'calender_state.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  final MerchantRepository _merchantRepository;
  CalenderBloc({required MerchantRepository merchantRepository})
      : _merchantRepository = merchantRepository,
        super(const CalenderState.initial()) {
    on<GetCalender>(_getCalender);
  }

  Future<void> _getCalender(
    GetCalender event,
    Emitter<CalenderState> emit,
  ) async {
    emit(const CalenderState.loading());

    try {
      final items = await _merchantRepository.getMerchantOffDaysRule(
          date: event.date, merchantId: event.merchantId, type: event.type);
      emit(CalenderState.success(items));
    } catch (error) {
      emit(CalenderState.failure(error.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rating_repository/rating_repository.dart';

part 'history_order_event.dart';
part 'history_order_state.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final RatingRepository _ratingRepository;

  HistoryOrderBloc({
    required RatingRepository ratingRepository,
  })  : _ratingRepository = ratingRepository,
        super(const HistoryOrderState.initial()) {
    on<GetHistoryOrder>(_getHistoryOrder);
  }

  Future<void> _getHistoryOrder(
    GetHistoryOrder event,
    Emitter<HistoryOrderState> emit,
  ) async {
    emit(const HistoryOrderState.loading());

    try {
      final items = await _ratingRepository.getListOrderHistory(event.status);

      emit(HistoryOrderState.success(items));
    } catch (error) {
      emit(HistoryOrderState.failure(error.toString()));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/pembeli/model/rating_input.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rating_repository/rating_repository.dart';

part 'add_rating_event.dart';
part 'add_rating_state.dart';

class AddRatingBloc extends Bloc<AddRatingEvent, AddRatingState> {
  final RatingRepository _ratingRepository;
  AddRatingBloc({
    required RatingRepository ratingRepository,
  })  : _ratingRepository = ratingRepository,
        super(const AddRatingState()) {
    ///
    on<SaveRating>(_saveRating);

    on<RatingChange>(_ratingChange);
  }

  Future<void> _saveRating(
    SaveRating event,
    Emitter<AddRatingState> emit,
  ) async {
    emit(state.copyWith(
      formzStatus: FormzStatus.submissionInProgress,
    ));

    try {
      await _ratingRepository.addRating(RatingModel(
          feedback: event.catatan,
          rating: event.rating,
          orderId: 'order1',
          userId: 'T64s0sUD0mMAyfZDTYpowf5nVei2',
          merchantId: 'merchant1'));

      emit(state.copyWith(
        formzStatus: FormzStatus.submissionSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(
        formzStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  void _ratingChange(
    RatingChange event,
    Emitter<AddRatingState> emit,
  ) {
    final rating = RatingInput.dirty(event.note);

    emit(state.copyWith(
      ratingInput: rating,
      formzStatus: Formz.validate([rating]),
    ));
  }
}

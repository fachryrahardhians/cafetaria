// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/pembeli/model/rating_input.dart';
import 'package:equatable/equatable.dart';

import 'package:formz/formz.dart';
import 'package:rating_repository/rating_repository.dart';
import 'package:uuid/uuid.dart';

part 'add_rating_event.dart';
part 'add_rating_state.dart';

class AddRatingBloc extends Bloc<AddRatingEvent, AddRatingState> {
  final RatingRepository _ratingRepository;
  // ignore: unused_field
  final AuthenticationRepository _authenticationRepository;
  AddRatingBloc(
      {required RatingRepository ratingRepository,
      required AuthenticationRepository authenticationRepository})
      : _ratingRepository = ratingRepository,
        _authenticationRepository = authenticationRepository,
        super(const AddRatingState()) {
    ///
    on<SaveRating>(_saveRating);

    on<RatingChange>(_ratingChange);
  }

  final _uuid = const Uuid();

  Future<void> _saveRating(
    SaveRating event,
    Emitter<AddRatingState> emit,
  ) async {
    emit(state.copyWith(
      formzStatus: FormzStatus.submissionInProgress,
    ));
    //  User? user = await _authenticationRepository.getCurrentUser();
    try {
      await _ratingRepository.addRating(
          event.orderId,
          RatingModel(
              feedback: event.catatan,
              rating: event.rating,
              ratingId: _uuid.v4(),
              merchantId: event.merchantId));

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

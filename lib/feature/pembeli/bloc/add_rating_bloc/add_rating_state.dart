part of 'add_rating_bloc.dart';

class AddRatingState extends Equatable {
  const AddRatingState({
    this.formzStatus = FormzStatus.pure,
    this.ratingInput = const RatingInput.pure(),
  });

  final FormzStatus formzStatus;
  final RatingInput ratingInput;

  @override
  List<Object?> get props => [
        formzStatus,
        RatingInput,
      ];

  AddRatingState copyWith({
    String? errorMessage,
    FormzStatus? formzStatus,
    RatingInput? ratingInput,
  }) {
    return AddRatingState(
      formzStatus: formzStatus ?? this.formzStatus,
      ratingInput: ratingInput ?? this.ratingInput,
    );
  }
}

part of 'add_rating_bloc.dart';

abstract class AddRatingEvent extends Equatable {
  const AddRatingEvent();

  @override
  List<Object> get props => [];
}

class SaveRating extends AddRatingEvent {
  final int rating;
  final String catatan;
  final String orderId;
  final String merchantId;

  const SaveRating(
      {required this.orderId,
      required this.rating,
      required this.catatan,
      required this.merchantId});

  @override
  List<Object> get props => [rating, catatan];
}

class RatingChange extends AddRatingEvent {
  final String note;

  const RatingChange(this.note);

  @override
  List<Object> get props => [note];
}
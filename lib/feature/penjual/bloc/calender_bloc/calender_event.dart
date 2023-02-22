part of 'calender_bloc.dart';

abstract class CalenderEvent extends Equatable {
  const CalenderEvent();

  @override
  List<Object> get props => [];
}

class GetCalender extends CalenderEvent {
  final String date;
  final String merchantId;
  final String type;
  const GetCalender(
      {required this.date, required this.merchantId, required this.type});
  @override
  List<Object> get props => [date, merchantId, type];
}

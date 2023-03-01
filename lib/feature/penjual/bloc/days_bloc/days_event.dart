part of 'days_bloc.dart';

abstract class DaysEvent extends Equatable {
  const DaysEvent();

  @override
  List<Object> get props => [];
}

class GetDays extends DaysEvent {
  final String merchantId;

  const GetDays({required this.merchantId});
  @override
  List<Object> get props => [merchantId];
}

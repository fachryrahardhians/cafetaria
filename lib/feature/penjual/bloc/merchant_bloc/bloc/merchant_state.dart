part of 'merchant_bloc.dart';

abstract class MerchantState extends Equatable {
  const MerchantState();
  
  @override
  List<Object> get props => [];
}

class MerchantInitial extends MerchantState {}

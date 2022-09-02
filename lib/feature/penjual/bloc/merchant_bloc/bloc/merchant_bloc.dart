import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'merchant_event.dart';
part 'merchant_state.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  MerchantBloc() : super(MerchantInitial()) {
    on<MerchantEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

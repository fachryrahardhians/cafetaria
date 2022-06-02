import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_makanan_event.dart';
part 'menu_makanan_state.dart';

class MenuMakananBloc extends Bloc<MenuMakananEvent, MenuMakananState> {
  MenuMakananBloc() : super(MenuMakananInitial()) {
    on<MenuMakananEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

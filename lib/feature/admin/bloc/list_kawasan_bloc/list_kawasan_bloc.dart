import 'package:admin_repository/admin_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_kawasan_event.dart';
part 'list_kawasan_state.dart';

class ListKawasanBloc extends Bloc<ListKawasanEvent, ListKawasanState> {
  final AdminRepository _adminRepository;
  ListKawasanBloc({
    required AdminRepository adminRepository,
  })  : _adminRepository = adminRepository,
        super(const ListKawasanState.initial()) {
    on<GetListKawasan>(_getListKawasan);
  }
  Future<void> _getListKawasan(
      GetListKawasan event, Emitter<ListKawasanState> emit) async {
    emit(const ListKawasanState.loading());

    try {
      final items = await _adminRepository.getListKawasan();

      emit(ListKawasanState.success(items));
    } catch (error) {
      emit(ListKawasanState.failure(error.toString()));
    }
  }
}

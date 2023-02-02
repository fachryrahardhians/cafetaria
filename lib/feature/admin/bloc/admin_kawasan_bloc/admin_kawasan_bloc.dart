import 'package:admin_repository/admin_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_kawasan_event.dart';
part 'admin_kawasan_state.dart';

class AdminKawasanBloc extends Bloc<AdminKawasanEvent, AdminKawasanState> {
  final AdminRepository _adminRepository;
  AdminKawasanBloc({
    required AdminRepository adminRepository,
  })  : _adminRepository = adminRepository,
        super(const AdminKawasanState.initial()) {
    on<GetAdmin>(_getListKawasan);
  }
  Future<void> _getListKawasan(
      GetAdmin event, Emitter<AdminKawasanState> emit) async {
    emit(const AdminKawasanState.loading());

    try {
      final items = await _adminRepository.getUserAdmin(event.userId);

      emit(AdminKawasanState.success(items));
    } catch (error) {
      emit(AdminKawasanState.failure(error.toString()));
    }
  }
}

import 'dart:async';

import 'package:admin_repository/admin_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'update_status_event.dart';
part 'update_status_state.dart';

class UpdateStatusBloc extends Bloc<UpdateStatusEvent, UpdateStatusState> {
  final AdminRepository _adminRepository;
  UpdateStatusBloc({
    required AdminRepository adminRepository,
  })  : _adminRepository = adminRepository,
        super(const UpdateStatusState()) {
    on<UpdateStatus>(_updateStatus);
  }
  FutureOr<void> _updateStatus(
    UpdateStatus event,
    Emitter<UpdateStatusState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: FormzStatus.submissionInProgress,
          idKawasan: event.idKawasan,
          stat: event.status
          // tersedia: state.tersedia
          ));

      // final stok1 = MenuModel(
      //     autoResetStock: state.restok,
      //     stock: int.parse(state.stokInput.value),
      //     resetType: state.tipeRestok.value,
      //    );

      await _adminRepository.updateStatus(
          state.idKawasan, state.stat, event.kawasan, event.idUser);

      emit(
        state.copyWith(
            status: FormzStatus.submissionSuccess,
            idKawasan: event.idKawasan,
            message: "Status berhasil Di Update",
            stat: event.status),
      );
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }
}

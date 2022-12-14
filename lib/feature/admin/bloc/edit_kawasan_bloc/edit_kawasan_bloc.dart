import 'dart:async';

import 'package:admin_repository/admin_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'edit_kawasan_event.dart';
part 'edit_kawasan_state.dart';

class EditKawasanBloc extends Bloc<EditKawasanEvent, EditKawasanState> {
  final AdminRepository _adminRepository;
  EditKawasanBloc({
    required AdminRepository adminRepository,
  })  : _adminRepository = adminRepository,
        super(const EditKawasanState()) {
    on<DeleteKawasan>(_deleteKawasan);
    on<EditKawasanChange>(_editKawasan);
    // on<NamaKawasanChange>(
    //   (event, emit) {
    //     emit(state.copyWith(
    //         message: state.message,
    //         name: event.name,
    //         status: state.status,
    //         idKawasan: state.idKawasan));
    //   },
    // );
  }
  FutureOr<void> _deleteKawasan(
    DeleteKawasan event,
    Emitter<EditKawasanState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
        idKawasan: event.idKawasan,
        // tersedia: state.tersedia
      ));

      // final stok1 = MenuModel(
      //     autoResetStock: state.restok,
      //     stock: int.parse(state.stokInput.value),
      //     resetType: state.tipeRestok.value,
      //    );

      await _adminRepository.deleteKawasan(state.idKawasan);

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          idKawasan: event.idKawasan,
          message: "Kawasan Berhasil Di hapus",
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }

  FutureOr<void> _editKawasan(
    EditKawasanChange event,
    Emitter<EditKawasanState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: FormzStatus.submissionInProgress,
          idKawasan: event.idKawasan,
          name: event.name
          // tersedia: state.tersedia
          ));

      // final stok1 = MenuModel(
      //     autoResetStock: state.restok,
      //     stock: int.parse(state.stokInput.value),
      //     resetType: state.tipeRestok.value,
      //    );

      await _adminRepository.updateKawasan(state.idKawasan, state.name);

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          idKawasan: event.idKawasan,
          name: event.name,
          message: "Kawasan Berhasil Di update",
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }
}

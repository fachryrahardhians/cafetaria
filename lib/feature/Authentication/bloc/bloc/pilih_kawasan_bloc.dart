import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:category_repository/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'pilih_kawasan_event.dart';
part 'pilih_kawasan_state.dart';

class PilihKawasanBloc extends Bloc<PilihKawasanEvent, PilihKawasanState> {
  final CategoryRepository _categoryRepository;
  PilihKawasanBloc({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const PilihKawasanState.initial()) {
    on<GetPilihKawasan>(_getPilihKawasan);
    on<GetDistanceKawasan>(_getDistanceKawasan);
    on<KawasanChange>(_kawasanChange);
    on<UpdateKawasan>(_updateKawasan);
  }

  Future<void> _getPilihKawasan(
      GetPilihKawasan event, Emitter<PilihKawasanState> emit) async {
    emit(const PilihKawasanState.loading());

    try {
      final items = await _categoryRepository.getPilihKawasan();

      emit(PilihKawasanState.success(items));
    } catch (error) {
      emit(PilihKawasanState.failure(error.toString()));
    }
  }

  Future<void> _getDistanceKawasan(
      GetDistanceKawasan event, Emitter<PilihKawasanState> emit) async {
    emit(const PilihKawasanState.loading());

    try {
      final items = await _categoryRepository.getDistanceKawasan(
          lat: double.parse(event.lat), long: double.parse(event.long));

      emit(PilihKawasanState.success(items));
    } catch (error) {
      emit(PilihKawasanState.failure(error.toString()));
    }
  }

  FutureOr<void> _kawasanChange(
    KawasanChange event,
    Emitter<PilihKawasanState> emit,
  ) {
    emit(state.copyWith(
        errorMessage: state.errorMessage,
        idkawasan: event.kawasan,
        items: state.items,
        status: state.status));
  }

  FutureOr<void> _updateKawasan(
    UpdateKawasan event,
    Emitter<PilihKawasanState> emit,
  ) async {
    try {
      emit(state.copyWith(
          inputStatus: FormzStatus.submissionInProgress,
          idkawasan: state.idkawasan
          // tersedia: state.tersedia
          ));

      await _categoryRepository.updateKawasan(event.idUser, state.idkawasan!);

      emit(
        state.copyWith(
          inputStatus: FormzStatus.submissionSuccess,
          idkawasan: state.idkawasan,
          errorMessage: "Kawasana berhasil Di Update",
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          inputStatus: FormzStatus.submissionFailure,
          errorMessage: e.toString()));
    }
  }
}

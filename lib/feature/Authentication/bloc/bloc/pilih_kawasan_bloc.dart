import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:category_repository/category_repository.dart';
import 'package:equatable/equatable.dart';

part 'pilih_kawasan_event.dart';
part 'pilih_kawasan_state.dart';

class PilihKawasanBloc extends Bloc<PilihKawasanEvent, PilihKawasanState> {
  final CategoryRepository _categoryRepository;
  PilihKawasanBloc({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const PilihKawasanState.initial()) {
    on<GetPilihKawasan>(_getPilihKawasan);
    on<KawasanChange>(_kawasanChange);
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
}

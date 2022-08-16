import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/penjual/model/restok_tipe.dart';
import 'package:cafetaria/feature/penjual/model/stok_input.dart';
import 'package:cafetaria/feature/penjual/model/time_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';

part 'atur_stock_bloc_event.dart';
part 'atur_stock_bloc_state.dart';

class AturStockBlocBloc extends Bloc<AturStockBlocEvent, AturStockBlocState> {
  final MenuRepository _menuRepository;
  AturStockBlocBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(const AturStockBlocState()) {
    on<AturStok>(_editStok);
    on<AturStokJumlah>(_aturStokJumlah);
    on<AturStokRestok>(_restok);
    on<AturStokRestokType>(_restokTipe);
    on<AturStokTersedia>(_tersedia);
    on<AturStokTime>(_timeRestok);
  }
  FutureOr<void> _editStok(
    AturStok event,
    Emitter<AturStockBlocState> emit,
  ) async {
    try {
      //print(event.stokBarang.toString());
      emit(state.copyWith(
          status: FormzStatus.submissionInProgress,
          stokInput: state.stokInput,
          tipeRestok: state.tipeRestok,
          restok: state.restok,
          timeReset: state.timeReset
          // tersedia: state.tersedia
          ));
      final stok;
      if (state.tersedia == false) {
        stok = event.stokBarang.copyWith(
            autoResetStock: false, stock: 0, resetType: "", resetTime: "");
      } else {
        print(state.tipeRestok);
        stok = event.stokBarang.copyWith(
            autoResetStock: state.restok,
            stock: int.parse(state.stokInput.value),
            resetType: state.tipeRestok.value,
            resetTime: state.timeReset.value);
      }

      // final stok1 = MenuModel(
      //     autoResetStock: state.restok,
      //     stock: int.parse(state.stokInput.value),
      //     resetType: state.tipeRestok.value,
      //    );
      await _menuRepository.editStockMenu(stok, "merchant2");
      print(stok.stock);
      emit(
        state.copyWith(
            status: FormzStatus.submissionSuccess,
            message: "Stok Berhasil Di Update",
            stokInput: state.stokInput,
            tipeRestok: state.tipeRestok,
            restok: state.restok,
            timeReset: state.timeReset),
      );
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }

  FutureOr<void> _aturStokJumlah(
    AturStokJumlah event,
    Emitter<AturStockBlocState> emit,
  ) {
    final stok = StokInput.dirty(event.qty);

    emit(state.copyWith(
        status: Formz.validate([stok]),
        stokInput: stok,
        restok: state.restok,
        tersedia: state.tersedia));
  }

  FutureOr<void> _restok(
    AturStokRestok event,
    Emitter<AturStockBlocState> emit,
  ) {
    emit(state.copyWith(
        status: state.status,
        stokInput: state.stokInput,
        restok: event.canReStok,
        tersedia: state.tersedia));
  }

  FutureOr<void> _tersedia(
    AturStokTersedia event,
    Emitter<AturStockBlocState> emit,
  ) {
    emit(state.copyWith(
        status: state.status,
        stokInput: state.stokInput,
        restok: state.restok,
        tersedia: event.isAvailable));
  }

  FutureOr<void> _timeRestok(
    AturStokTime event,
    Emitter<AturStockBlocState> emit,
  ) {
    final time = TimeInput.dirty(event.time);
    emit(state.copyWith(
        status: Formz.validate([time]),
        stokInput: state.stokInput,
        restok: state.restok,
        tersedia: state.tersedia,
        timeReset: time));
  }

  FutureOr<void> _restokTipe(
    AturStokRestokType event,
    Emitter<AturStockBlocState> emit,
  ) {
    final type = RestokTipeInput.dirty(event.restokTipe);
    //test mencoba return value string tipe restok
    emit(state.copyWith(
        status: Formz.validate([type]),
        stokInput: state.stokInput,
        tipeRestok: type,
        restok: state.restok,
        tersedia: state.tersedia));
    print("Tipe : ${Formz.validate([type])}");
  }

  //  FutureOr<void> _restokTime(
  //   AturStokTime event,
  //   Emitter<AturStockBlocState> emit,
  // ) {

  //   emit(state.copyWith(
  //       status:state.status,
  //       stokInput: state.stokInput,
  //       tipeRestok: state.tipeRestok,
  //       restok: state.restok,

  //       tersedia: state.tersedia));
  // }
}

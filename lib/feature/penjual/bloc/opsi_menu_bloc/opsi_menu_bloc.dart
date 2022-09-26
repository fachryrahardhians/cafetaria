import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:cafetaria/feature/penjual/model/opsi_input.dart';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:uuid/uuid.dart';

part 'opsi_menu_event.dart';
part 'opsi_menu_state.dart';

class OpsiMenuBloc extends Bloc<OpsiMenuEvent, OpsiMenuState> {
  OpsiMenuBloc({
    required OptionMenuRepository optionMenuRepository,
  })  : _optionMenuRepository = optionMenuRepository,
        super(const OpsiMenuState()) {
    on<OpsiMenuChange>(_opsiMenuChange);
    on<WajibChecked>(_wajibChecked);
    on<BanyakPorsiChecked>(_banyakPorsiChecked);
    on<OptionChange>(_optionChange);

    on<SaveOpsi>(_saveOpsi);
    on<OptionIsiChange>(_optionIsiChange);
  }
  final OptionMenuRepository _optionMenuRepository;

  FutureOr<void> _opsiMenuChange(
      OpsiMenuChange event, Emitter<OpsiMenuState> emit) {
    final name = OpsiInput.dirty(event.name);
    emit(state.copyWith(
        status: Formz.validate([name]),
        banyakOpsi: state.banyakOpsi,
        opsiInput: name,
        option: state.option,
        wajibMemilih: state.wajibMemilih));
  }

  FutureOr<void> _wajibChecked(
      WajibChecked event, Emitter<OpsiMenuState> emit) {
    emit(state.copyWith(
        status: state.status,
        banyakOpsi: state.banyakOpsi,
        opsiInput: state.opsiInput,
        option: state.option,
        wajibMemilih: event.wajib));
  }

  FutureOr<void> _banyakPorsiChecked(
      BanyakPorsiChecked event, Emitter<OpsiMenuState> emit) {
    emit(state.copyWith(
        status: state.status,
        banyakOpsi: event.porsi,
        opsiInput: state.opsiInput,
        option: state.option,
        wajibMemilih: state.wajibMemilih));
  }

  FutureOr<void> _optionChange(
      OptionChange event, Emitter<OpsiMenuState> emit) {
    var option = <Option>[];
    option.addAll(state.option);
    option.add(event.option);
    emit(state.copyWith(
        status: state.status,
        banyakOpsi: state.banyakOpsi,
        opsiInput: state.opsiInput,
        option: option,
        wajibMemilih: state.wajibMemilih));
  }

  FutureOr<void> _optionIsiChange(
      OptionIsiChange event, Emitter<OpsiMenuState> emit) {
    var option = <Option>[];
    option.addAll(state.option);
    option[event.index] = event.option;
    emit(state.copyWith(
        status: state.status,
        banyakOpsi: state.banyakOpsi,
        opsiInput: state.opsiInput,
        option: option,
        wajibMemilih: state.wajibMemilih));
  }

  Future<FutureOr<void>> _saveOpsi(
      SaveOpsi event, Emitter<OpsiMenuState> emit) async {
    const _uuid = Uuid();
    emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
        banyakOpsi: state.banyakOpsi,
        opsiInput: state.opsiInput,
        option: state.option,
        wajibMemilih: state.wajibMemilih));
    List<Option> listOption = state.option;
    print(listOption);
    final opsi = OptionMenuModel(
        menuId: event.menuId,
        isMandatory: state.wajibMemilih,
        isMultipleTopping: state.banyakOpsi,
        optionmenuId: _uuid.v4(),
        title: state.opsiInput.value,
        option: listOption);

    await _optionMenuRepository.saveOptionMenu(opsi);

    emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        banyakOpsi: state.banyakOpsi,
        opsiInput: state.opsiInput,
        option: state.option,
        wajibMemilih: state.wajibMemilih));
  }
}

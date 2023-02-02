import 'package:admin_repository/admin_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'add_info_event.dart';
part 'add_info_state.dart';

class AddInfoBloc extends Bloc<AddInfoEvent, AddInfoState> {
  final AdminRepository _adminRepository;
  final _uuid = const Uuid();
  AddInfoBloc({
    required AdminRepository adminRepository,
  })  : _adminRepository = adminRepository,
        super(AddInfoState()) {
    on<AddInfo>(_addInfo);
    on<Updateinfo>(_updateInfo);
    on<DeleteInfo>(_deleteInfo);
  }
  void _addInfo(
    AddInfo event,
    Emitter<AddInfoState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: FormzStatus.submissionInProgress,
          body: event.body,
          imageUri: event.imageUri,
          judul: event.judul,
          kadarluasa: event.kadarluasa,
          kawasanId: event.kawasanId,
          statusInfo: event.statusInfo,
          terbit: event.terbit,
          tipe: event.tipe));
      final info = InfoModel(
          infoId: _uuid.v4(),
          kawasanId: event.kawasanId,
          body: state.body,
          expDate: state.kadarluasa,
          image: state.imageUri,
          publishDate: state.terbit,
          status: state.statusInfo,
          title: state.judul,
          type: state.tipe);
      await _adminRepository.addInfo(info);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          body: state.body,
          imageUri: state.imageUri,
          judul: state.judul,
          kadarluasa: state.kadarluasa,
          kawasanId: state.kawasanId,
          statusInfo: state.statusInfo,
          terbit: state.terbit,
          tipe: state.tipe));
    } catch (e) {
      rethrow;
    }
  }

  void _updateInfo(
    Updateinfo event,
    Emitter<AddInfoState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: FormzStatus.submissionInProgress,
          body: event.body,
          imageUri: event.imageUri,
          judul: event.judul,
          kadarluasa: event.kadarluasa,
          kawasanId: event.kawasanId,
          statusInfo: event.statusInfo,
          terbit: event.terbit,
          tipe: event.tipe));
      final info = InfoModel(
          infoId: event.infoId,
          kawasanId: event.kawasanId,
          body: state.body,
          expDate: state.kadarluasa,
          image: state.imageUri,
          publishDate: state.terbit,
          status: state.statusInfo,
          title: state.judul,
          type: state.tipe);
      await _adminRepository.updateInfo(info);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          body: state.body,
          imageUri: state.imageUri,
          judul: state.judul,
          kadarluasa: state.kadarluasa,
          kawasanId: state.kawasanId,
          statusInfo: state.statusInfo,
          terbit: state.terbit,
          tipe: state.tipe));
    } catch (e) {
      rethrow;
    }
  }

  void _deleteInfo(
    DeleteInfo event,
    Emitter<AddInfoState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: FormzStatus.submissionInProgress,
          body: state.body,
          imageUri: state.imageUri,
          judul: state.judul,
          kadarluasa: state.kadarluasa,
          kawasanId: state.kawasanId,
          statusInfo: state.statusInfo,
          terbit: state.terbit,
          tipe: state.tipe));
      await _adminRepository.deleteInfo(event.infoModel);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          body: state.body,
          imageUri: state.imageUri,
          judul: state.judul,
          kadarluasa: state.kadarluasa,
          kawasanId: state.kawasanId,
          statusInfo: state.statusInfo,
          terbit: state.terbit,
          tipe: state.tipe));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          body: state.body,
          imageUri: state.imageUri,
          judul: state.judul,
          kadarluasa: state.kadarluasa,
          kawasanId: state.kawasanId,
          statusInfo: state.statusInfo,
          terbit: state.terbit,
          tipe: state.tipe));
      rethrow;
    }
  }
}

import 'package:admin_repository/admin_repository.dart';
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
        super(const AddInfoState()) {
    on<AddInfo>(_addInfo);
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
          kawasanId: "e574154f-cde0-4b49-a678-c19d1fed1bb6",
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
      print(e);
    }
  }
}

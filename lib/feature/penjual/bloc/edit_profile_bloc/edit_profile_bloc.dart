import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(const EditProfileState()) {
    on<EditProfileSubmit>(_editProfile);
  }
  Future<void> _editProfile(
    EditProfileSubmit event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final data = {
        'name': event.name,
        'city': event.kota,
        'postal_code': event.postalCode,
        'address': event.address,
        'address_detail': event.addressDetail,
        'address_latitude': event.addressLatitude,
        'address_longitude': event.addressLongitude,
        'image': event.urlBanner,
      };
      await FirebaseFirestore.instance
          .collection('merchant')
          .doc(event.merchantId)
          .update(data);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (error) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: error.toString()));
    }
  }
}

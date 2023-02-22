part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final FormzStatus status;
  final String errorMessage;
  const EditProfileState(
      {this.status = FormzStatus.pure, this.errorMessage = ""});

  @override
  List<Object> get props => [status, errorMessage];
  EditProfileState copyWith({
    // bool? status,
    String? errorMessage,
    FormzStatus? status,
  }) {
    return EditProfileState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

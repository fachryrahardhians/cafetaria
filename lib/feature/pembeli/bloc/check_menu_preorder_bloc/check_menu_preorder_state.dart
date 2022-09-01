part of 'check_menu_preorder_bloc.dart';

class MenuPreorderState extends Equatable {
  const MenuPreorderState();

  @override
  List<Object?> get props => [];
}

class CheckLoading extends MenuPreorderState {}

class CheckResult extends MenuPreorderState {
  final bool result;
  const CheckResult(this.result);
}

class CheckFailed extends MenuPreorderState {
  final String message;
  const CheckFailed(this.message);
}

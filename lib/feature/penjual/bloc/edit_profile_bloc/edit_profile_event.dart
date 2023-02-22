part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileSubmit extends EditProfileEvent {
  final String name;
  final String kota;
  final String postalCode;
  final String address;
  final String addressDetail;
  final double addressLatitude;
  final double addressLongitude;
  final String urlBanner;
  final String merchantId;

  const EditProfileSubmit(
      {required this.merchantId,
      required this.name,
      required this.kota,
      required this.postalCode,
      required this.address,
      required this.addressDetail,
      required this.addressLatitude,
      required this.addressLongitude,
      required this.urlBanner});
}

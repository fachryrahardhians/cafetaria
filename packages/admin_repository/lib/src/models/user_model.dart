import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String userId;
  final String email;
  final String fullname;
  const UserModel(
      {required this.userId, required this.email, required this.fullname});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  @override
  List<Object?> get props => [
        userId, email, //createdAt, //geolocation,
        fullname,
      ];

  UserModel copyWith({String? userId, String? email, String? fullname}) {
    return UserModel(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        fullname: fullname ?? this.fullname);
  }
}

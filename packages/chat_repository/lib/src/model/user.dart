import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModelChat extends Equatable {
  //final DateTime createdAt;
  final String address;
  final String? email;
  //final GeoPoint? geolocation;
  final String? fullname;

  final String userId;

  // final DateTime updatedAt;
  const UserModelChat({
    required this.userId,
    required this.address,
    this.email,
    // required this.createdAt,
    //this.geolocation,

    this.fullname,

    //required this.updatedAt
  });
  factory UserModelChat.fromJson(Map<String, dynamic> json) =>
      _$UserModelChatFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelChatToJson(this);
  @override
  List<Object?> get props => [userId, address, email, fullname];

  UserModelChat copyWith({
    String? userId,
    String? address,
    String? email,
    String? fullname,
  }) {
    return UserModelChat(
      userId: userId ?? this.userId,
      address: address ?? this.address,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
    );
  }
}

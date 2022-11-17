import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_admin_model.g.dart';

@JsonSerializable()
class SubAdmin {
  final String? status;
  final String? userId;

  const SubAdmin({this.status, this.userId});
  factory SubAdmin.fromJson(Map<String, dynamic> json) =>
      _$SubAdminFromJson(json);

  Map<String, dynamic> toJson() => _$SubAdminToJson(this);

  @override
  List<Object?> get props => [status, userId];

  SubAdmin copyWith({String? status, String? userId}) {
    return SubAdmin(
        status: status ?? this.status, userId: userId ?? this.userId);
  }
}

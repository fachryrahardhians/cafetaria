import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_room.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatRoom extends Equatable {
  //final DateTime createdAt;
  final String source;
  final DateTime createdAt;
  //final GeoPoint? geolocation;
  final String? messageId;

  final String? message;

  // final DateTime updatedAt;
  const ChatRoom({
    required this.source,
    required this.createdAt,
    this.messageId,
    // required this.createdAt,
    //this.geolocation,

    this.message,

    //required this.updatedAt
  });
  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
  @override
  List<Object?> get props => [source, message, messageId, createdAt];

  ChatRoom copyWith({
    DateTime? createdAt,
    String? source,
    String? messageId,
    String? message,
  }) {
    return ChatRoom(
      createdAt: createdAt ?? this.createdAt,
      source: source ?? this.source,
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
    );
  }
}

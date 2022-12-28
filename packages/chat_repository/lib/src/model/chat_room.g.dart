// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      source: json['source'] as String,
      createdAt: json['createdAt'].toDate() as DateTime,
      messageId: json['messageId'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'source': instance.source,
      'createdAt': instance.createdAt.toIso8601String(),
      'messageId': instance.messageId,
      'message': instance.message,
    };

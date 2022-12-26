// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushMessage _$PushMessageFromJson(Map<String, dynamic> json) => PushMessage(
      source: json['source'] as String,
      dest: json['dest'] as String,
      messageId: json['messageId'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PushMessageToJson(PushMessage instance) =>
    <String, dynamic>{
      'dest': instance.dest,
      'source': instance.source,
      'messageId': instance.messageId,
      'message': instance.message,
    };

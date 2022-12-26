import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_message.g.dart';

@JsonSerializable(explicitToJson: true)
class PushMessage extends Equatable {
  final String dest;
  final String source;
  // final DateTime createdAt;
  //final GeoPoint? geolocation;
  final String? messageId;

  final String? message;

  // final DateTime updatedAt;
  const PushMessage({
    required this.source,
    required this.dest,
    this.messageId,
    // required this.createdAt,
    //this.geolocation,

    this.message,

    //required this.updatedAt
  });
  factory PushMessage.fromJson(Map<String, dynamic> json) =>
      _$PushMessageFromJson(json);

  Map<String, dynamic> toJson() => _$PushMessageToJson(this);
  @override
  List<Object?> get props => [];

  PushMessage copyWith({
    String? dest,
    String? source,
    String? messageId,
    String? message,
  }) {
    return PushMessage(
      dest: dest ?? this.dest,
      source: source ?? this.source,
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
    );
  }
}

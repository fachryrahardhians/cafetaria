// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => InfoModel(
      body: json['body'],
      infoId: json['infoId'] as String,
      kawasanId: json['kawasanId'] as String,
      expDate: json['expDate'] as String?,
      image: json['image'] as String?,
      publishDate: json['publishDate'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$InfoModelToJson(InfoModel instance) => <String, dynamic>{
      'body': instance.body,
      'expDate': instance.expDate,
      'image': instance.image,
      'infoId': instance.infoId,
      'kawasanId': instance.kawasanId,
      'publishDate': instance.publishDate,
      'status': instance.status,
      'title': instance.title,
      'type': instance.type,
    };

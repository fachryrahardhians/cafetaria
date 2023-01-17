import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InfoModel extends Equatable {
  final String? body;
  final String? expDate;
  final String? image;
  final String infoId;
  final String kawasanId;
  final String? publishDate;
  final String? status;
  final String? title;
  final String? type;
  const InfoModel(
      {this.body,
      required this.infoId,
      required this.kawasanId,
      this.expDate,
      // required this.createdAt,
      //this.geolocation,
      this.image,
      this.publishDate,
      this.title,
      this.type,
      this.status
      //required this.updatedAt
      });
  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
  @override
  List<Object?> get props => [
        body, infoId, //createdAt, //geolocation,
        kawasanId,
        expDate, image,
        publishDate,
        title,
        type,
        status
      ];

  InfoModel copyWith(
      {String? body,
      String? expDate,
      String? image,
      String? infoId,
      String? kawasanId,
      String? publishDate,
      String? status,
      String? title,
      String? type}) {
    return InfoModel(
        body: body ?? this.body,
        expDate: expDate ?? this.expDate,
        kawasanId: kawasanId ?? this.kawasanId,
        image: image ?? this.image,
        infoId: infoId ?? this.infoId,
        publishDate: publishDate ?? this.publishDate,
        status: status ?? this.status,
        title: title ?? this.title,
        type: type ?? this.type);
  }
}

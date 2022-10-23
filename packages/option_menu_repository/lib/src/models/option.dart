import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'option.g.dart';

/// OptionMenuModel
@JsonSerializable()
class Option extends Equatable {
  /// OptionMenuModel
  const Option({
    required this.name,
    required this.price,
  });

  /// from Json
  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$OptionToJson(this);

  /// name
  final String? name;

  /// price
  final int? price;

  @override
  List<Object?> get props => [
        name,
        price,
      ];

  /// copyWith - [OptionMenuModel]
  Option copyWith({
    String? name,
    int? price,
  }) {
    return Option(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}

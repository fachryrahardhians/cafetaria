import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable()
class Options extends Equatable {
  final String? name;
  final int? price;

  const Options({this.name, this.price});
  Options copyWith({String? name, int? price}) {
    return Options(name: name ?? this.name, price: price ?? this.price);
  }

  factory Options.fromJson(Map<String, dynamic> json) =>
      _$OptionsFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsToJson(this);
  @override
  // TODO: implement props
  List<Object?> get props => [name, price];
}

// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

import 'merchant_search_model.dart';

part 'merchant_search.g.dart';

@JsonSerializable(explicitToJson: true)
class MechantSearch extends Equatable {
  const MechantSearch(
      {this.type, //this.score, 
      this.id, this.index, this.source});

  factory MechantSearch.fromJson(Map<String, dynamic> json) =>
      _$MechantSearchFromJson(json);
  final String? type;
  //final double? score;
  final String? id;
  final MerchantSearchModel? source;
  final String? index;

  Map<String, dynamic> toJson() => _$MechantSearchToJson(this);

  /// Copy with a new [MechantSearch].
  MechantSearch copyWith(
      {String? type,
     // double? score,
      String? id,
      MerchantSearchModel? source,
      String? index}) {
    return MechantSearch(
        type: type ?? this.type,
       // score: score ?? this.score,
        id: id ?? this.id,
        source: source ?? this.source,
        index: index ?? this.index);
  }

  @override
  List<Object?> get props => [type, //score, 
  id, source, index];
}
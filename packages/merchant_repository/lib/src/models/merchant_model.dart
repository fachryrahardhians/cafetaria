import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'merchant_model.g.dart';

@JsonSerializable()
class MerchantModel extends Equatable {
  final int? maxPrice;
  final String? merchantId;
  final int? minPrice;
  final String? name;
  final double? rating;
  final String? test;
  final int? totalCountRating;
  final int? totalOrderToday;
  final int? totalSalesToday;
  final int? totalSalesYesterday;
  final String? userId;

  const MerchantModel(
      {this.maxPrice,
      this.merchantId,
      this.minPrice,
      this.name,
      this.rating,
      this.test,
      this.totalCountRating,
      this.totalOrderToday,
      this.totalSalesToday,
      this.totalSalesYesterday,
      this.userId});

  factory MerchantModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantModelToJson(this);

  /// Copy with a new [MerchantModel].
  MerchantModel copyWith({
    int? maxPrice,
    String? merchantId,
    int? minPrice,
    String? nama,
    double? rating,
    String? test,
    int? totalCountRating,
    int? totalOrderToday,
    int? totalSalesToday,
    int? totalSalesYesterday,
    String? userId,
  }) {
    return MerchantModel(
      maxPrice: maxPrice ?? this.maxPrice,
      merchantId: merchantId ?? this.merchantId,
      minPrice: minPrice ?? this.minPrice,
      name: nama ?? this.name,
      rating: rating ?? this.rating,
      test: test ?? this.test,
      totalCountRating: totalCountRating ?? this.totalCountRating,
      totalOrderToday: totalOrderToday ?? this.totalOrderToday,
      totalSalesToday: totalSalesToday ?? this.totalSalesToday,
      totalSalesYesterday: totalSalesYesterday ?? this.totalSalesYesterday,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [];
}

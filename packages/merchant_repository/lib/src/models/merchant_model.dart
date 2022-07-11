import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'merchant_model.g.dart';

@JsonSerializable()
class MerchantModel extends Equatable {
  final String? maxPrice;
  final String? merchantId;
  final String? minPrice;
  final String? nama;
  final String? rating;
  final String? test;
  final String? totalCountRating;
  final String? totalOrderToday;
  final String? totalSalesToday;
  final String? totalSalesYesterday;
  final String? userId;

  const MerchantModel(
      {this.maxPrice,
      this.merchantId,
      this.minPrice,
      this.nama,
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
    String? maxPrice,
    String? merchantId,
    String? minPrice,
    String? nama,
    String? rating,
    String? test,
    String? totalCountRating,
    String? totalOrderToday,
    String? totalSalesToday,
    String? totalSalesYesterday,
    String? userId,
  }) {
    return MerchantModel(
      maxPrice: maxPrice ?? this.maxPrice,
      merchantId: merchantId ?? this.merchantId,
      minPrice: minPrice ?? this.minPrice,
      nama: nama ?? this.nama,
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

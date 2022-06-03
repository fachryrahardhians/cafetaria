// To parse this JSON data, do
//
//     final categoryMenuModel = categoryMenuModelFromJson(jsonString);

import 'dart:convert';

CategoryMenuModel categoryMenuModelFromJson(String str) =>
    CategoryMenuModel.fromJson(json.decode(str));

String categoryMenuModelToJson(CategoryMenuModel data) =>
    json.encode(data.toJson());

class CategoryMenuModel {
  CategoryMenuModel({
    required this.category,
    required this.categoryId,
    required this.merchantId,
  });

  String category;
  String? categoryId;
  String? merchantId;

  factory CategoryMenuModel.fromJson(Map<String, dynamic> json) =>
      CategoryMenuModel(
        category: json["category"],
        categoryId: json["categoryId"],
        merchantId: json["merchantId"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "categoryId": categoryId,
        "merchantId": merchantId,
      };
}

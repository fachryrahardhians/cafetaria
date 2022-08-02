// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  MenuModel({
    required this.menuId,
    required this.merchantId,
    required this.nama,
  });

  String? menuId;
  String? merchantId;
  String? nama;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        menuId: json["menuId"],
        merchantId: json["merchantId"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "merchantId": merchantId,
        "nama": nama,
      };
}

// To parse this JSON data, do
//
//     final inventory = inventoryFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

MakananModel inventoryFromJson(String str) =>
    MakananModel.fromJson(json.decode(str));

String inventoryToJson(MakananModel data) => json.encode(data.toJson());

class MakananModel {
  MakananModel({
    required this.success,
    required this.data,
    required this.message,
    required this.code,
  });

  final bool success;
  final dynamic data;
  final String message;
  final int code;

  factory MakananModel.fromJson(Map<String, dynamic> json) {
    return MakananModel(
      success: json["success"],
      data: json["success"] ? Data.fromJson(json['data']) : json['data'],
      message: json["message"],
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
        "code": code,
      };
}

class Data {
  Data({
    required this.menus,
    required this.countFiltered,
    required this.countTotal,
  });
  final List<Menu> menus;
  final int countFiltered;
  final int countTotal;

  factory Data.fromJson(Map<String, dynamic> json) {
    List<Menu> list =
        List<Menu>.from(json['lists'].map((e) => Menu.fromJson(e)));
    return Data(
      menus: list,
      countFiltered: json["countFiltered"],
      countTotal: json["countTotal"],
    );
  }
}

class Menu {
  Menu({
    required this.itemId,
    required this.price,
    required this.toppings,
    required this.itemName,
    required this.category,
    required this.etalase,
    required this.percentPromo,
    required this.merchantId,
    required this.itemDesc,
    required this.isActivePromo,
    required this.tags,
  });

  final String itemId;
  final int price;
  final List<dynamic> toppings;
  final String itemName;
  final String category;
  final String etalase;
  final double percentPromo;
  final String merchantId;
  final String itemDesc;
  final bool isActivePromo;
  final List<String> tags;

  factory Menu.fromJson(Map<String, dynamic> json) {
    List<dynamic> topping =
        json['topping'].map((e) => Topping.fromJson(e)).toList();
    List<String> tag = List<String>.from(json['tags']);
    return Menu(
      itemId: json['itemId'],
      price: json['price'],
      toppings: topping,
      itemName: json['itemName'],
      category: json['category'],
      etalase: json['etalase'],
      percentPromo: json['percentPromo'] / 1,
      merchantId: json['merchantId'],
      itemDesc: json['itemDesc'],
      isActivePromo: json['isActivePromo'],
      tags: tag,
    );
  }

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "price": price,
        "topping": toppings,
        "itemName": itemName,
        "category": category,
        "etalase": etalase,
        "percentPromo": percentPromo,
        "merchantId": merchantId,
        "itemDesc": itemDesc,
        "isActivePromo": isActivePromo,
        "tags": tags,
      };
}

class Topping {
  Topping({required this.name, required this.price});
  final String name;
  final int price;

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(name: json["item"], price: json["price"]);
  }

  Map<String, dynamic> toJson() => {
        "item": name,
        "price": price,
      };
}

class MenuNotifier extends ChangeNotifier {
  static List<Menu> _data = new List<Menu>.empty(growable: true);

  List<Menu> get getData => _data;

  void addMenuData(Menu order) {
    _data.add(order);
    notifyListeners();
  }

  void resetMenuData(Menu order) {
    _data.clear();
    notifyListeners();
  }
}

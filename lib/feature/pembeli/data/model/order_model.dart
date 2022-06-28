// To parse this JSON data, do
//
//     final inventory = inventoryFromJson(jsonString);

import 'dart:convert';

import 'package:cafetaria/feature/pembeli/data/model/makanan_model.dart';
import 'package:flutter/cupertino.dart';

String inventoryToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    required this.userId,
    required this.apartmentId,
    required this.merchantId,
    required this.orders,
  });

  final String userId;
  final String merchantId;
  final String apartmentId;
  final List<FoodOrder> orders;

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "merchantId": merchantId,
        "apartementId": apartmentId,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class FoodOrder {
  FoodOrder(
      {required this.item,
      required this.note,
      required this.qty,
      required this.merchantId,
      required this.totalPrice});

  final String merchantId;
  final Item item;
  String note;
  int qty;
  int totalPrice;

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
        "note": note,
        "qty": qty,
      };
}

class Item {
  Item({
    required this.itemId,
    required this.price,
    required this.toppings,
    required this.itemName,
  });

  final String itemId;
  final int price;
  List<dynamic> toppings;
  final String itemName;

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "price": price,
        "topping": List<dynamic>.from(toppings.map((x) => x.toJson())),
        "itemName": itemName,
      };
}

class Toppings {
  Toppings({required this.name, required this.price});
  final String name;
  final int price;

  Map<String, dynamic> toJson() => {
        "item": name,
        "price": price,
      };
}

class OrderNotifier extends ChangeNotifier {
  static List<FoodOrder> _data = new List<FoodOrder>.empty(growable: true);
  static List<Menu> _Menudata = new List<Menu>.empty(growable: true);

  List<FoodOrder> get getData => _data;
  List<Menu> get getMenuData => _Menudata;

  void addMenuData(Menu menu) {
    _Menudata.add(menu);
    notifyListeners();
  }

  void removeMenuData(Menu menu) {
    _Menudata.removeWhere((element) => element.itemId == menu.itemId);
    notifyListeners();
  }

  void addData(FoodOrder order) {
    _data.add(order);
    notifyListeners();
  }

  void removeData(FoodOrder order) {
    _data.removeWhere((element) => element.item.itemId == order.item.itemId);
    notifyListeners();
  }

  void updateData(FoodOrder order) {
    int index =
        _data.indexWhere((element) => element.item.itemId == order.item.itemId);
    _data[index].qty = order.qty;
    _data[index].item.toppings = order.item.toppings;
    _data[index].totalPrice = order.totalPrice;
    _data[index].note = order.note;
    notifyListeners();
  }

  int getTotalPrice() {
    int price = 0;
    _data.forEach((element) {
      price += element.totalPrice;
    });
    return price;
  }

  int getTotalQty() {
    int qty = 0;
    _data.map((e) => qty += e.qty);
    _data.forEach((element) {
      qty += element.qty;
    });
    return qty;
  }
}

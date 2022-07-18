import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PenjualOrderModel extends Equatable {
  final int? cash;
  final String? change;
  final String? deviceToken;
  final bool? isCutlery;
  final bool? isPreorder;
  final List<PenjualOrderMenu>? menus;
  final String? merchantId;
  final String? orderId;
  final Timestamp? pickupDate;
  final String? statusOrder;
  final Timestamp? timestamp;
  final int? total;
  final String? typePickup;
  final String? userId;

  const PenjualOrderModel(
      {this.cash,
      this.change,
      this.deviceToken,
      this.isCutlery,
      this.isPreorder,
      this.menus,
      this.merchantId,
      this.orderId,
      this.pickupDate,
      this.statusOrder,
      this.timestamp,
      this.total,
      this.typePickup,
      this.userId});

  @override
  List<Object?> get props => [
        cash,
        change,
        deviceToken,
        isCutlery,
        isPreorder,
        menus,
        merchantId,
        orderId,
        pickupDate,
        statusOrder,
        timestamp,
        total,
        typePickup,
        userId,
      ];

  factory PenjualOrderModel.fromJson(Map<String,dynamic> json) =>
      PenjualOrderModel(
        cash : json['cash'],
        change : json['change'],
        deviceToken : json['deviceToken'],
        isCutlery : json['isCutlery'],
        isPreorder : json['isPreorder'],
        menus: json["menus"] == null ? null : List<PenjualOrderMenu>.from(json["menus"]
            .map((x) => PenjualOrderMenu.fromJson(x))),
        merchantId : json['merchantId'],
        orderId : json['orderId'],
        pickupDate : json['pickupDate'],
        statusOrder : json['statusOrder'],
        timestamp : json['timestamp'],
        total : json['total'],
        typePickup : json['typePickup'],
        userId : json['userId'],
      );

    Map<String,dynamic> toJson() => {
      "cash" : cash,
      "change" : change,
      "deviceToken" : deviceToken,
      "isCutlery" : isCutlery,
      "isPreorder" : isPreorder,
      "menus": menus == null ? null : List<dynamic>.from(menus!.map((x) => x
          .toJson())),
      "merchantId" : merchantId,
      "orderId" : orderId,
      "pickupDate" : pickupDate,
      "statusOrder" : statusOrder,
      "timestamp" : timestamp,
      "total" : total,
      "typePickup" : typePickup,
      "userId" : userId,
    };
}

class PenjualOrderMenu extends Equatable {
  final String? menuId;
  final String? notes;
  final int? price;
  final int? qty;
  final List<PenjualOrderMenuTopping>? toppings;

  const PenjualOrderMenu({
    this.menuId,
    this.notes,
    this.price,
    this.qty,
    this.toppings,
  });

  factory PenjualOrderMenu.fromJson(Map<String,dynamic> json) =>
      PenjualOrderMenu(
        menuId : json['menuId'] ,
        notes : json['notes'] ,
        price : json['price'] ,
        qty : json['qty'] ,
        toppings: json["toppings"] == null ? null : List<PenjualOrderMenuTopping>.from(json["toppings"].map((x) => PenjualOrderMenuTopping.fromJson(x))),
      );

  Map<String,dynamic> toJson() => {
    'menuId': menuId,
    'notes': notes,
    'price': price,
    'qty': qty,
    "toppings": toppings == null ? null : List<dynamic>.from(toppings!.map(
            (x) => x.toJson())),
  };

  @override
  List<Object?> get props => [
        menuId,
        notes,
        price,
        qty,
        toppings,
      ];
}

class PenjualOrderMenuTopping extends Equatable {
  final List<PenjualOrderMenuToppingItem>? items;

  const PenjualOrderMenuTopping({
    this.items,
  });

  factory PenjualOrderMenuTopping.fromJson(Map<String,dynamic> json) =>
      PenjualOrderMenuTopping(
        items: json["items"] == null ? null : List<PenjualOrderMenuToppingItem>.from(json["items"].map((x) => PenjualOrderMenuToppingItem.fromJson(x))),
      );

  Map<String,dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x
        .toJson())),
  };

  @override
  List<Object?> get props => [items];
}

class PenjualOrderMenuToppingItem extends Equatable {
  final String? name;
  final int? price;

  const PenjualOrderMenuToppingItem({
    this.name,
    this.price,
  });

  factory PenjualOrderMenuToppingItem.fromJson(Map<String,dynamic> json) =>
      PenjualOrderMenuToppingItem(
        name: json['name'],
        price: json['price']
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };


@override
  List<Object?> get props => [
        name,
        price,
      ];
}

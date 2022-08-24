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
  final String? docId;
  final String? keterangan;

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
      this.userId,
      this.docId,
      this.keterangan});

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
        docId,
      ];

  PenjualOrderModel copyWithOrderStatus(
    String statusOrder,
    String? keterangan, {
    int? cash,
    String? change,
  }) =>
      PenjualOrderModel(
        cash: cash ?? this.cash,
        change: change ?? this.change,
        deviceToken: deviceToken,
        isCutlery: isCutlery,
        isPreorder: isPreorder,
        menus: menus,
        merchantId: merchantId,
        orderId: orderId,
        pickupDate: pickupDate,
        statusOrder: statusOrder,
        keterangan: keterangan ?? this.keterangan,
        timestamp: timestamp,
        total: total,
        typePickup: typePickup,
        userId: userId,
        docId: docId,
      );

  factory PenjualOrderModel.fromJson(Map<String, dynamic> json, String id) =>
      PenjualOrderModel(
          cash: json['cash'],
          change: json['change'],
          deviceToken: json['deviceToken'],
          isCutlery: json['isCutlery'],
          isPreorder: json['isPreorder'],
          menus: json["menus"] == null
              ? null
              : List<PenjualOrderMenu>.from(
                  json["menus"].map((x) => PenjualOrderMenu.fromJson(x))),
          merchantId: json['merchantId'],
          orderId: json['orderId'],
          pickupDate: json['pickupDate'],
          statusOrder: json['statusOrder'],
          timestamp: json['timestamp'],
          total: json['total'],
          typePickup: json['typePickup'],
          userId: json['userId'],
          docId: id,
          keterangan: json['keterangan']);

  Map<String, dynamic> toJson() => {
        "cash": cash,
        "change": change,
        "deviceToken": deviceToken,
        "isCutlery": isCutlery,
        "isPreorder": isPreorder,
        "menus": menus == null
            ? null
            : List<dynamic>.from(menus!.map((x) => x.toJson())),
        "merchantId": merchantId,
        "orderId": orderId,
        "pickupDate": pickupDate,
        "statusOrder": statusOrder,
        "timestamp": timestamp,
        "total": total,
        "typePickup": typePickup,
        "userId": userId,
        "keterangan": keterangan,
      };
}

class PenjualOrderMenu extends Equatable {
  final String? menuId;
  final String? notes;
  final int? price;
  final int? qty;
  final List<PenjualOrderMenuTopping>? toppings;
  final DetailMenu? detailMenu;

  const PenjualOrderMenu({
    this.menuId,
    this.notes,
    this.price,
    this.qty,
    this.toppings,
    this.detailMenu,
  });

  factory PenjualOrderMenu.fromJson(Map<String, dynamic> json) =>
      PenjualOrderMenu(
        menuId: json['menuId'],
        notes: json['notes'],
        price: json['price'],
        qty: json['qty'],
        toppings: json["toppings"] == null
            ? null
            : List<PenjualOrderMenuTopping>.from(json["toppings"]
                .map((x) => PenjualOrderMenuTopping.fromJson(x))),
        detailMenu: json['detailMenu'] == null
            ? null
            : DetailMenu.fromJson(json['detailMenu']),
      );

  Map<String, dynamic> toJson() => {
        'menuId': menuId,
        'detailMenu': detailMenu?.toJson(),
        'notes': notes,
        'price': price,
        'qty': qty,
        "toppings": toppings == null
            ? null
            : List<dynamic>.from(toppings!.map((x) => x.toJson())),
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

class DetailMenu extends Equatable {
  final String? name;
  final String? desc;
  final String? image;
  final bool? autoResetStock;
  final String? categoryId;
  final bool? isPreOrder;
  final bool? isRecomended;
  final String? menuId;
  final String? merchantId;
  final int? price;
  final int? stock;
  final String? rulepreordermenuId;

  // final String image;

  const DetailMenu({
    this.name,
    this.desc,
    this.image,
    this.autoResetStock,
    this.categoryId,
    this.isPreOrder,
    this.isRecomended,
    this.menuId,
    this.merchantId,
    this.price,
    this.stock,
    this.rulepreordermenuId,
  });

  factory DetailMenu.fromJson(Map<String, dynamic> json) => DetailMenu(
        name: json['name'],
        desc: json['desc'],
        image: json['image'],
        autoResetStock: json['autoResetStock'],
        categoryId: json['categoryId'],
        isPreOrder: json['isPreOrder'],
        isRecomended: json['isRecomended'],
        menuId: json['menuId'],
        merchantId: json['merchantId'],
        price: json['price'],
        stock: json['stock'],
        rulepreordermenuId: json['rulepreordermenuId'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "image": image,
        "autoResetStock": autoResetStock,
        "categoryId": categoryId,
        "isPreOrder": isPreOrder,
        "isRecomended": isRecomended,
        "menuId": menuId,
        "merchantId": merchantId,
        "price": price,
        "stock": stock,
        "rulepreordermenuId": rulepreordermenuId,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        desc,
      ];
}

class PenjualOrderMenuTopping extends Equatable {
  final List<PenjualOrderMenuToppingItem>? items;

  const PenjualOrderMenuTopping({
    this.items,
  });

  factory PenjualOrderMenuTopping.fromJson(Map<String, dynamic> json) =>
      PenjualOrderMenuTopping(
        items: json["items"] == null
            ? null
            : List<PenjualOrderMenuToppingItem>.from(json["items"]
                .map((x) => PenjualOrderMenuToppingItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
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

  factory PenjualOrderMenuToppingItem.fromJson(Map<String, dynamic> json) =>
      PenjualOrderMenuToppingItem(name: json['name'], price: json['price']);

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

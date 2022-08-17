// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      orderId: json['orderId'] as String?,
      cash: json['cash'] as int?,
      change: json['change'] as String?,
      deviceToken: json['deviceToken'] as String?,
      isCutlery: json['isCutlery'] as bool?,
      isPreorder: json['isPreorder'] as bool?,
      pickupDate: json['pickupDate'].toDate().toString() as String?,
      typePickup: json['typePickup'] as String?,
      userId: json['userId'] as String?,
      merchantId: json['merchantId'] as String?,
      total: json['total'] as int?,
      timestamp: json['timestamp'].toDate().toString() as String?,
      statusOrder: json['statusOrder'] as String?,
      menus: (json['menus'] as List<dynamic>?)?.map((e) => OrderMenu.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'cash': instance.cash,
      'change': instance.change,
      'deviceToken': instance.deviceToken,
      'isCutlery': instance.isCutlery,
      'isPreorder': instance.isPreorder,
      'pickupDate': Timestamp.fromDate(DateTime.parse(instance.pickupDate!)),
      'typePickup': instance.typePickup,
      'merchantId': instance.merchantId,
      'userId': instance.userId,
      'total': instance.total,
      'timestamp': Timestamp.fromDate(DateTime.parse(instance.timestamp!)),
      'statusOrder': instance.statusOrder,
      'menus': instance.menus,
    };

OrderMenu _$OrderMenuFromJson(Map<String, dynamic> json) => OrderMenu(
      menuId: json['menuId'] as String?,
      qty: json['qty'] as int?,
      price: json['price'] as int?,
      toppings: (json['toppings'] as List<dynamic>?)
          ?.map((e) => OrderTopping.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$OrderMenuToJson(OrderMenu instance) => <String, dynamic>{
      'menuId': instance.menuId,
      'notes': instance.notes,
      'name': instance.name,
      'price': instance.price,
      'qty': instance.qty,
      'toppings': instance.toppings,
    };

OrderTopping _$OrderToppingFromJson(Map<String, dynamic> json) => OrderTopping(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ToppingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToppingToJson(OrderTopping instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

ToppingItem _$ToppingItemFromJson(Map<String, dynamic> json) => ToppingItem(
      name: json['name'] as String?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$ToppingItemToJson(ToppingItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };

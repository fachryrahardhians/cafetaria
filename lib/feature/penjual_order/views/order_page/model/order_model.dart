// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

class GroupedOrderDetail {
  GroupedOrderDetail({required this.original});

  final List<OrderModel> original;

  List<OrderModel> get baru => _getterGroupedPesanan("baru");
  List<OrderModel> get booking => _getterGroupedPesanan("booking");
  List<OrderModel> get ditolak => _getterGroupedPesanan("baru");
  List<OrderModel> get diterima => _getterGroupedPesanan("baru");


  _getterGroupedPesanan(String status) =>
      original.where((element) => element.statusOrder == status);

}

class OrderModel {
  OrderModel({
    this.cash,
    this.change,
    this.isCultery,
    this.isPreOrder,
    this.menus,
    this.merchantId,
    this.orderId,
    this.pickupDate,
    this.statusOrder,
    this.timestamp,
    this.total,
    this.userId,
  });

  String? cash;
  String? change;
  String? isCultery;
  String? isPreOrder;
  List<Menu>? menus;
  String? merchantId;
  String? orderId;
  String? pickupDate;
  String? statusOrder;
  String? timestamp;
  int? total;
  String? userId;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      OrderModel(
        cash: json["cash"] == null ? null : json["cash"],
        change: json["change"] == null ? null : json["change"],
        isCultery: json["isCultery"] == null ? null : json["isCultery"],
        isPreOrder: json["isPreOrder"] == null ? null : json["isPreOrder"],
        menus: json["menus"] == null ? null : List<Menu>.from(
            json["menus"].map((x) => Menu.fromJson(x))),
        merchantId: json["merchantId"] == null ? null : json["merchantId"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        pickupDate: json["pickupDate"] == null ? null : json["pickupDate"],
        statusOrder: json["statusOrder"] == null ? null : json["statusOrder"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        total: json["total"] == null ? null : json["total"],
        userId: json["userId"] == null ? null : json["userId"],
      );

  Map<String, dynamic> toJson() =>
      {
        "cash": cash == null ? null : cash,
        "change": change == null ? null : change,
        "isCultery": isCultery == null ? null : isCultery,
        "isPreOrder": isPreOrder == null ? null : isPreOrder,
        "menus": menus == null ? null : List<dynamic>.from(menus!.map((x) =>
            x
                .toJson())),
        "merchantId": merchantId == null ? null : merchantId,
        "orderId": orderId == null ? null : orderId,
        "pickupDate": pickupDate == null ? null : pickupDate,
        "statusOrder": statusOrder == null ? null : statusOrder,
        "timestamp": timestamp == null ? null : timestamp,
        "total": total == null ? null : total,
        "userId": userId == null ? null : userId,
      };
}

class Menu {
  Menu({
    this.menuId,
    this.menuName,
    this.notes,
    this.price,
    this.qty,
    this.toppings,
  });

  String? menuId;
  String? menuName;
  String? notes;
  int? price;
  int? qty;
  List<Topping>? toppings;

  factory Menu.fromJson(Map<String, dynamic> json) =>
      Menu(
        menuId: json["menuId"] == null ? null : json["menuId"],
        menuName: json["menuName"] == null ? null : json["menuName"],
        notes: json["notes"] == null ? null : json["notes"],
        price: json["price"] == null ? null : json["price"],
        qty: json["qty"] == null ? null : json["qty"],
        toppings: json["toppings"] == null ? null : List<Topping>.from(
            json["toppings"].map((x) => Topping.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "menuId": menuId == null ? null : menuId,
        "menuName": menuName == null ? null : menuName,
        "notes": notes == null ? null : notes,
        "price": price == null ? null : price,
        "qty": qty == null ? null : qty,
        "toppings": toppings == null ? null : List<dynamic>.from(toppings!.map(
                (x) => x.toJson())),
      };
}

class Topping {
  Topping({
    this.items,
  });

  List<Item>? items;

  factory Topping.fromJson(Map<String, dynamic> json) =>
      Topping(
        items: json["items"] == null ? null : List<Item>.from(
            json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "items": items == null ? null : List<dynamic>.from(items!.map((x) =>
            x
                .toJson())),
      };
}

class Item {
  Item({
    this.name,
    this.price,
  });

  String? name;
  int? price;

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name == null ? null : name,
        "price": price == null ? null : price,
      };
}

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

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        cash: json["cash"],
        change: json["change"],
        isCultery: json["isCultery"],
        isPreOrder: json["isPreOrder"],
        menus: json["menus"] == null
            ? null
            : List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
        merchantId: json["merchantId"],
        orderId: json["orderId"],
        pickupDate: json["pickupDate"],
        statusOrder: json["statusOrder"],
        timestamp: json["timestamp"],
        total: json["total"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "cash": cash,
        "change": change,
        "isCultery": isCultery,
        "isPreOrder": isPreOrder,
        "menus": menus == null
            ? null
            : List<dynamic>.from(menus!.map((x) => x.toJson())),
        "merchantId": merchantId,
        "orderId": orderId,
        "pickupDate": pickupDate,
        "statusOrder": statusOrder,
        "timestamp": timestamp,
        "total": total,
        "userId": userId,
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

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        menuId: json["menuId"],
        menuName: json["menuName"],
        notes: json["notes"],
        price: json["price"],
        qty: json["qty"],
        toppings: json["toppings"] == null
            ? null
            : List<Topping>.from(
                json["toppings"].map((x) => Topping.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "menuName": menuName,
        "notes": notes,
        "price": price,
        "qty": qty,
        "toppings": toppings == null
            ? null
            : List<dynamic>.from(toppings!.map((x) => x.toJson())),
      };
}

class Topping {
  Topping({
    this.items,
  });

  List<Item>? items;

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.name,
    this.price,
  });

  String? name;
  int? price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}

import 'package:get/get.dart';

class MenuModelObs {
  String? menuId;
  bool? autoResetStock;
  bool? isRecomended;
  dynamic resetType;
  String? merchantId;
  dynamic rulepreordermenuId;
  bool? isPreOrder;
  List<String>? tags;
  String? desc;
  int? stock;
  int? price;
  dynamic resetTime;
  String? image;
  String? name;
  String? categoryId;
  RxBool selected = false.obs;

  MenuModelObs({
    this.menuId,
    this.autoResetStock,
    this.isRecomended,
    this.resetType,
    this.merchantId,
    this.rulepreordermenuId,
    this.isPreOrder,
    this.tags,
    this.desc,
    this.stock,
    this.price,
    this.resetTime,
    this.image,
    this.name,
    this.categoryId,
  });

  MenuModelObs.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    autoResetStock = json['autoResetStock'];
    isRecomended = json['isRecomended'];
    resetType = json['resetType'];
    merchantId = json['merchantId'];
    rulepreordermenuId = json['rulepreordermenuId'];
    isPreOrder = json['isPreOrder'];
    tags = json['tags'].cast<String>();
    desc = json['desc'];
    stock = json['stock'];
    price = json['price'];
    resetTime = json['resetTime'];
    image = json['image'];
    name = json['name'];
    categoryId = json['categoryId'];
    selected.value = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuId'] = menuId;
    data['autoResetStock'] = autoResetStock;
    data['isRecomended'] = isRecomended;
    data['resetType'] = resetType;
    data['merchantId'] = merchantId;
    data['rulepreordermenuId'] = rulepreordermenuId;
    data['isPreOrder'] = isPreOrder;
    data['tags'] = tags;
    data['desc'] = desc;
    data['stock'] = stock;
    data['price'] = price;
    data['resetTime'] = resetTime;
    data['image'] = image;
    data['name'] = name;
    data['categoryId'] = categoryId;
    data['selected'] = selected.value;
    return data;
  }
}

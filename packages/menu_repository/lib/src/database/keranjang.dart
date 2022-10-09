import 'package:hive/hive.dart';
part 'keranjang.g.dart';

@HiveType(typeId: 0)
class Keranjang extends HiveObject {
  // @HiveField(0)
  // List simNumber;
  @HiveField(0)
  final String? menuId;
  @HiveField(1)
  final String? merchantId;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final bool? autoResetStock;
  @HiveField(4)
  final String? categoryId;
  @HiveField(5)
  final String? desc;
  @HiveField(6)
  final String? image;
  @HiveField(7)
  final bool? isPreOrder;
  @HiveField(8)
  final bool? isRecomended;
  @HiveField(9)
  final int? price;
  @HiveField(10)
  final String? resetTime;
  @HiveField(11)
  final String? resetType;
  @HiveField(12)
  final String? rulepreordermenuId;
  @HiveField(13)
  final int? stock;
  @HiveField(14)
  final List<String>? tags;
  @HiveField(15)
  int quantity;
  @HiveField(16)
  int totalPrice;
  @HiveField(17)
  final String? notes;
  @HiveField(18)
  List<ListOption>? options;
  Keranjang(
      {this.menuId,
      this.merchantId,
      this.name,
      this.autoResetStock,
      this.categoryId,
      this.desc,
      this.image,
      this.isPreOrder,
      this.isRecomended,
      this.price,
      this.resetTime,
      this.resetType,
      this.rulepreordermenuId,
      this.options,
      this.stock,
      this.tags,
      required this.quantity,
      required this.totalPrice,
      this.notes});
}

@HiveType(typeId: 1)
class ListOption extends HiveObject {
  // @HiveField(0)
  // List simNumber;
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? price;

  ListOption({
    this.name,
    this.price,
  });
}

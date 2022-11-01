import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:uuid/uuid.dart';

// import 'models/models.dart';

class MenuRepository {
  final FirebaseFirestore _firestore;
  final uuid = const Uuid();
  Box<Keranjang> keranjangBox = Hive.box<Keranjang>('keranjangBox');

  MenuRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  // get  menu per merchant
  Future<List<MenuModel>> getMenuByMerchant(
    String idMerchant,
  ) async {
    try {
      final snapshot =
          await _firestore.collection('menuPerMerchant-$idMerchant').get();

      final documents = snapshot.docs;
      return documents.toListMenu();
    } catch (e) {
      throw Exception('Failed to get menu');
    }
  }

  Future<void> updateFcmToken(String id, String token) async {
    try {
      await _firestore
          .collection('user')
          .doc(id)
          .update({'deviceToken': token});
    } catch (e) {
      throw Exception('Failed to Update Stock Menu');
    }
  }

  Future<List<MenuRead>> getMenuRead(
    String idMerchant,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('menu-read')
          .where('merchantId', isEqualTo: idMerchant)
          .get();

      final documents = snapshot.docs;
      return documents.toListMenu2();
    } catch (e) {
      throw Exception('Failed to get menu');
    }
  }

  Future<RulePreorderModel> getRuleById(String id) async {
    try {
      final snapshot =
          await _firestore.collection('rulepreordermenu').doc(id).get();

      final documents = snapshot.data();
      return RulePreorderModel.fromJson(documents!);
    } catch (e) {
      throw Exception('Failed to get Preorder Rules');
    }
  }

  Future<List<MenuModel>> getRecommendedMenuByMerchant(
    String idMerchant,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('menuPerMerchant-$idMerchant')
          .where("isRecomended", isEqualTo: true)
          .get();

      final documents = snapshot.docs.toListMenu();
      return documents;
    } catch (e) {
      throw Exception('Failed to get menu');
    }
  }

  Future<List<MenuModel>> getMenu(
    String idMerchant,
    String idCategory,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('menu')
          .where('categoryId', isEqualTo: idCategory)
          .where("merchantId", isEqualTo: idMerchant)
          .get();

      final documents = snapshot.docs;
      return documents.toListMenu();
    } catch (e) {
      throw Exception('Failed to get menu');
    }
  } // get  menu per merchant

  Future<List<MenuModel>> getAllMenu(
    String idMerchant,
  ) async {
    try {
      final snapshot =
          await _firestore.collection('menuPerMerchant-$idMerchant').get();

      final documents = snapshot.docs;
      return documents.toListMenu();
    } catch (e) {
      throw Exception('Failed to get All menu');
    }
  } // get menu per merchant

  Future<List<MenuModel>> getMenuStokTidakTersedia(
    String idMerchant,
    String idCategory,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('menuPerMerchant-$idMerchant')
          .where('stock', isEqualTo: 0)
          .get();

      final documents = snapshot.docs;
      return documents.toListMenu();
    } catch (e) {
      throw Exception('Failed to get menu');
    }
  }

  Future<void> addMenu(MenuModel menu) async {
    try {
      await _firestore.collection('menu').doc(menu.menuId).set(menu.toJson());
    } catch (e) {
      throw Exception('Failed to get menu');
    }
  }

  Future<void> editMenu(MenuModel menu) async {
    try {
      await _firestore
          .collection('menu')
          .doc(menu.menuId)
          .update(menu.toJson());
    } catch (e) {
      throw Exception('Failed to edit menu');
    }
  }

  Future<void> editStockMenu(MenuModel menu, String idMerchant) async {
    try {
      await _firestore
          .collection('menu')
          .doc(menu.menuId)
          .update(menu.toJson());
    } catch (e) {
      throw Exception('Failed to Update Stock Menu');
    }
  }

  Future<void> addMenutoKeranjang(
      MenuModel menu,
      int qty,
      int totalPrice,
      String? notes,
      List<Options>? option,
      List<ToppingOrder>? multiple) async {
    try {
      keranjangBox.add(Keranjang(
          menuId: menu.menuId,
          merchantId: menu.merchantId,
          name: menu.name,
          autoResetStock: menu.autoResetStock,
          categoryId: menu.categoryId,
          desc: menu.desc,
          image: menu.image,
          isPreOrder: menu.isPreOrder,
          isRecomended: menu.isRecomended,
          price: menu.price,
          resetTime: menu.resetTime,
          resetType: menu.resetType,
          rulepreordermenuId: menu.rulepreordermenuId,
          stock: menu.stock,
          tags: menu.tags,
          quantity: qty,
          totalPrice: totalPrice,
          options: option?.map((e) {
            return ListOption(name: e.name, price: e.price.toString());
          }).toList(),
          toppings: multiple,
          notes: notes));
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> updateMenuKeranjang(Keranjang keranjang) async {
    await keranjang.save();
  }

  Future<List<Keranjang>> getMenuInKeranjang() async {
    try {
      Iterable<Keranjang> keranjang = keranjangBox.values;
      return keranjang.toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> deleteMenuFromKeranjang(Keranjang keranjang) async {
    await keranjang.delete();
  }

  Future<void> deleteAllMenuInKeranjang() async {
    await keranjangBox.clear();
  }
}

extension on List<QueryDocumentSnapshot> {
  List<MenuModel> toListMenu() {
    final leaderboardEntries = <MenuModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          leaderboardEntries.add(MenuModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}

extension on List<QueryDocumentSnapshot> {
  List<MenuRead> toListMenu2() {
    final leaderboardEntries = <MenuRead>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          leaderboardEntries.add(MenuRead.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}

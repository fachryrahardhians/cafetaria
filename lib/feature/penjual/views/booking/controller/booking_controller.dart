import 'package:cafetaria/feature/penjual/model/menu_model_obs.dart';
import 'package:cafetaria/feature/penjual/model/preorder.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool issetSelected = false.obs;
  TextEditingController jarakC = TextEditingController();
  TextEditingController maxPorsiC = TextEditingController();
  RxBool showPorsi = true.obs;
  RxBool isDone = false.obs;

  DateTime? selectedTime;

  // PREORDER
  PreOrder? preOrder;

  // ALL MENU
  RxList<List<MenuModelObs>> menu = List<List<MenuModelObs>>.empty().obs;
  List<String> allCategoryMenu = [];

  // ALL BOOKING => isPreOrder = true
  RxList<List<MenuModelObs>> booking = List<List<MenuModelObs>>.empty().obs;
  List<String> allCategoryBooking = [];
  late String merchantId;

  // STREAM
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllBooking() async* {
    yield* _firestore
        .collection("menu")
        .where("merchantId", isEqualTo: merchantId)
        .where("isPreOrder", isEqualTo: true)
        .snapshots();
  }

  // FUTURE
  Future<void> getAllMenu() async {
    var querySnap =
        await _firestore.collection("menuPerMerchant-$merchantId").get();

    allCategoryMenu = [];

    for (var queryMenu in querySnap.docs) {
      MenuModelObs menu = MenuModelObs.fromJson(queryMenu.data());
      if (allCategoryMenu.contains(menu.categoryId)) {
        continue;
      } else {
        allCategoryMenu.add(menu.categoryId!);
      }
    }

    List<List<MenuModelObs>> allMenu = [];

    for (var category in allCategoryMenu) {
      List<MenuModelObs> allMenuByCategory = [];
      for (var queryMenu in querySnap.docs) {
        MenuModelObs menu = MenuModelObs.fromJson(queryMenu.data());
        if (menu.categoryId == category) {
          allMenuByCategory.add(menu);
        }
      }
      allMenu.add(allMenuByCategory);
    }

    menu(allMenu);
    menu.refresh();
  }

  Future<void> getAllBooking() async {
    booking([]);
    booking.refresh();
    var querySnap = await _firestore
        .collection("menuPerMerchant-$merchantId")
        .where("isPreOrder", isEqualTo: true)
        .get();

    allCategoryBooking = [];

    for (var queryMenu in querySnap.docs) {
      MenuModelObs menu = MenuModelObs.fromJson(queryMenu.data());
      if (allCategoryBooking.contains(menu.categoryId)) {
        continue;
      } else {
        allCategoryBooking.add(menu.categoryId!);
      }
    }

    List<List<MenuModelObs>> allMenu = [];

    for (var category in allCategoryBooking) {
      List<MenuModelObs> allMenuByCategory = [];
      for (var queryMenu in querySnap.docs) {
        MenuModelObs menu = MenuModelObs.fromJson(queryMenu.data());
        if (menu.categoryId == category) {
          allMenuByCategory.add(menu);
        }
      }
      allMenu.add(allMenuByCategory);
    }

    booking(allMenu);
    booking.refresh();
  }

  Future<String> getCategoryName(String catId) async {
    var query = await _firestore.collection("category").doc(catId).get();
    return query.data()!["category"].toString().toUpperCase();
  }

  Future<void> aturJamPengambilan(context) async {
    DateTime? pick = await DatePicker.showTime12hPicker(
      context,
      showTitleActions: true,
      currentTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      theme: const DatePickerTheme(
        backgroundColor: MyColors.white,
      ),
    );

    if (pick != null) {
      selectedTime = pick;
      update();
      checkDone();
    }
  }

  Future<void> addBooking() async {
    for (var element in menu) {
      for (var e in element) {
        if (e.selected.isTrue) {
          await _firestore
              .collection("menu")
              .doc(e.menuId)
              .update({"isPreOrder": true});

          var querySnap = await _firestore
              .collection("rulepreordermenu")
              .where("merchantId", isEqualTo: merchantId)
              .get();
          late String docIdTime;
          if (querySnap.docs.isNotEmpty) {
            docIdTime = querySnap.docs.first.id;
            await _firestore
                .collection("rulepreordermenu")
                .doc(docIdTime)
                .update({
              "isShowPublic": showPorsi.value,
              "maxQty": maxPorsiC.text.isEmpty ? 0 : int.parse(maxPorsiC.text),
              "merchantId": merchantId,
              "pickupTime": selectedTime?.toIso8601String(),
              "poDay": jarakC.text.isEmpty ? 0 : int.parse(jarakC.text),
              "rulepreordermenuId": docIdTime,
            });
          } else {
            var queryRaw = await _firestore.collection("rulepreordermenu").add({
              "isShowPublic": showPorsi.value,
              "maxQty": maxPorsiC.text.isEmpty ? 0 : int.parse(maxPorsiC.text),
              "merchantId": merchantId,
              "pickupTime": selectedTime?.toIso8601String(),
              "poDay": jarakC.text.isEmpty ? 0 : int.parse(jarakC.text),
            });
            docIdTime = queryRaw.id;
            await _firestore
                .collection("rulepreordermenu")
                .doc(docIdTime)
                .update({"rulepreordermenuId": docIdTime});
          }

          await _firestore
              .collection("menu")
              .doc(e.menuId)
              .update({"rulepreordermenuId": docIdTime});
        }
      }
    }
  }

  Future<void> editBooking() async {
    for (var element in menu) {
      for (var e in element) {
        if (e.selected.isTrue) {
          await _firestore
              .collection("menu")
              .doc(e.menuId)
              .update({"isPreOrder": true});
        } else {
          await _firestore
              .collection("menu")
              .doc(e.menuId)
              .update({"isPreOrder": false});
        }
      }
    }
  }

  Future<void> editSettingBooking() async {
    try {
      var querySnap = await _firestore
          .collection("rulepreordermenu")
          .where("merchantId", isEqualTo: merchantId)
          .get();
      late String docIdTime;

      docIdTime = querySnap.docs.first.id;
      await _firestore.collection("rulepreordermenu").doc(docIdTime).update({
        "isShowPublic": showPorsi.value,
        "maxQty": maxPorsiC.text.isEmpty ? 0 : int.parse(maxPorsiC.text),
        "merchantId": merchantId,
        "pickupTime": selectedTime?.toIso8601String(),
        "poDay": jarakC.text.isEmpty ? 0 : int.parse(jarakC.text),
        "rulepreordermenuId": docIdTime,
      });
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> getOrderTime() async {
    try {
      var querySnap = await _firestore
          .collection("rulepreordermenu")
          .where("merchantId", isEqualTo: merchantId)
          .get();
      if (querySnap.docs.isNotEmpty) {
        preOrder = PreOrder.fromJson(querySnap.docs.first.data());
      }
    } catch (e) {
      preOrder = null;
    }
  }

  // VOID
  void checkSelected(MenuModelObs dataMenu) {
    issetSelected.value = false;
    dataMenu.selected.toggle();

    for (var menuByCategory in menu) {
      for (var menu in menuByCategory) {
        if (menu.selected.isTrue) {
          issetSelected.value = true;
        }
      }
    }
  }

  void deleteBooking(List<MenuModelObs> menuByCategory) async {
    for (var element in menuByCategory) {
      await _firestore.collection("menu").doc(element.menuId).update({
        "isPreOrder": false,
      });
    }
  }

  void addAllDocBooking(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> raw) async {
    booking([]);
    booking.refresh();

    allCategoryBooking = [];

    for (var queryBooking in raw) {
      MenuModelObs menu = MenuModelObs.fromJson(queryBooking.data());
      if (allCategoryBooking.contains(menu.categoryId)) {
        continue;
      } else {
        allCategoryBooking.add(menu.categoryId!);
      }
    }

    List<List<MenuModelObs>> allMenu = [];

    for (var category in allCategoryBooking) {
      List<MenuModelObs> allMenuByCategory = [];
      for (var queryMenu in raw) {
        MenuModelObs menu = MenuModelObs.fromJson(queryMenu.data());
        if (menu.categoryId == category) {
          allMenuByCategory.add(menu);
        }
      }
      allMenu.add(allMenuByCategory);
    }

    booking(allMenu);
    booking.refresh();
  }

  void checkDone() {
    if (jarakC.text.isEmpty) {
      isDone.value = false;
    } else {
      if (maxPorsiC.text.isEmpty) {
        isDone.value = false;
      } else {
        if (selectedTime == null) {
          isDone.value = false;
        } else {
          isDone.value = true;
        }
      }
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // TODO: @kuldii => Penentuan merchant masih hard code
    // merchantId = "merchant1";

    //get id merchant menggunakan shared preference
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String idMerchant = logindata.getString('merchantId').toString();

    merchantId = idMerchant;
  }

  @override
  void onClose() {
    super.onClose();
    issetSelected.value = false;
    menu.clear();
    allCategoryMenu = [];
    booking.clear();
    allCategoryBooking = [];
    merchantId = "";
  }
}

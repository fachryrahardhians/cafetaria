// ignore_for_file: avoid_print

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/app.dart';
import 'package:cafetaria/bootstrap.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';
import 'package:storage/storage.dart';

void main() async {
  bootstrap(
    (
      firebaseAuth,
      firebaseStore,
      sharedpreference,
    ) async {
      //
      final _authenticationRepository = AuthenticationRepository(firebaseAuth);
      final _menuRepository = MenuRepository(firestore: firebaseStore);
      final _categoryRepository = CategoryRepository(firestore: firebaseStore);
      final _merchantRepository = MerchantRepository(firestore: firebaseStore);
      final _sharedPref = AppSharedPref(sharedpreference);
      final _opsimenuRepository = OptionMenuRepository(firestore: firebaseStore);
      final _penjualOrderRepository =
          PenjualOrderRepository(firestore: firebaseStore);
      final _cloudStorage = CloudStorage();
      const _secureStorage = SecureStorage();

      final fcmToken = await FirebaseMessaging.instance.getToken();

      print(fcmToken);

      // Initialize Firebase

      return App(
        appSharedPref: _sharedPref,
        authenticationRepository: _authenticationRepository,
        merchantRepository: _merchantRepository,
        optionMenuRepository: _opsimenuRepository,
        menuRepository: _menuRepository,
        categoryRepository: _categoryRepository,
        secureStorage: _secureStorage,
        cloudStorage: _cloudStorage,
        penjualOrderRepository: _penjualOrderRepository,
      );
    },
  );
}

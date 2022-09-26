// ignore_for_file: avoid_print

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/app.dart';
import 'package:cafetaria/bootstrap.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

import 'package:order_repository/order_repository.dart';
import 'package:rating_repository/rating_repository.dart';
import 'package:storage/storage.dart';

void main() async {
  bootstrap(
    (
      firebaseAuth,
      firebaseStore,
      sharedpreference,
    ) async {
      //
      var appDocumentDirectory =
          await pathProvider.getApplicationDocumentsDirectory();

      Hive.init(appDocumentDirectory.path);
      Hive.registerAdapter<Keranjang>(KeranjangAdapter());

      await Hive.openBox<Keranjang>('keranjangBox');
      final _authenticationRepository = AuthenticationRepository(firebaseAuth);
      final _menuRepository = MenuRepository(firestore: firebaseStore);
      final _categoryRepository = CategoryRepository(firestore: firebaseStore);
      final _merchantRepository = MerchantRepository(firestore: firebaseStore);
      final _sharedPref = AppSharedPref(sharedpreference);
      final _optionMenuRepository =
          OptionMenuRepository(firestore: firebaseStore);
      final _penjualOrderRepository =
          PenjualOrderRepository(firestore: firebaseStore);
      final _cloudStorage = CloudStorage();
      const _secureStorage = SecureStorage();
      final _ratingRepository = RatingRepository(firestore: firebaseStore);
      final _orderRepository = OrderRepository(firestore: firebaseStore);

      final fcmToken = await FirebaseMessaging.instance.getToken();
      _authenticationRepository.saveFcmToken(fcmToken ?? "");

      print(fcmToken);

      // Initialize Firebase

      return App(
        optionMenuRepository: _optionMenuRepository,
        appSharedPref: _sharedPref,
        authenticationRepository: _authenticationRepository,
        menuRepository: _menuRepository,
        categoryRepository: _categoryRepository,
        secureStorage: _secureStorage,
        cloudStorage: _cloudStorage,
        ratingRepository: _ratingRepository,
        orderRepository: _orderRepository,
        merchantRepository: _merchantRepository,
        penjualOrderRepository: _penjualOrderRepository,
      );
    },
  );
}

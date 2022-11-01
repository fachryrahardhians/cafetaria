// ignore_for_file: avoid_print

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/app.dart';
import 'package:cafetaria/bootstrap.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

import 'package:order_repository/order_repository.dart';
import 'package:rating_repository/rating_repository.dart';
import 'package:storage/storage.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> requestNotificationPermission(FirebaseMessaging messaging) async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

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
      final _optionMenuRepository =
          OptionMenuRepository(firestore: firebaseStore);
      final _penjualOrderRepository =
          PenjualOrderRepository(firestore: firebaseStore);
      final _cloudStorage = CloudStorage();
      const _secureStorage = SecureStorage();
      final _ratingRepository = RatingRepository(firestore: firebaseStore);
      final _orderRepository = OrderRepository(firestore: firebaseStore);
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      final fcmToken = await _firebaseMessaging.getToken();
      _authenticationRepository.saveFcmToken(fcmToken ?? "");
      // print(fcmToken);
      // Initialize Firebase
      WidgetsFlutterBinding.ensureInitialized();
      await requestNotificationPermission(_firebaseMessaging);
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      if (!kIsWeb) {
        channel = const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          description:
              'This channel is used for important notifications.', // description
          importance: Importance.high,
        );

        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);

        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
      return App(
        optionMenuRepository: _optionMenuRepository,
        appSharedPref: _sharedPref,
        channel: channel,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
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

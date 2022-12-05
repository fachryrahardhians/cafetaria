import 'package:admin_repository/admin_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/bloc/app_bloc.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/Authentication/views/pilih_kawasan.dart';
import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';

import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:rating_repository/rating_repository.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:storage/storage.dart';

import 'package:sharedpref_repository/sharedpref_repository.dart';

class App extends StatefulWidget {
  const App(
      {Key? key,
      required AuthenticationRepository authenticationRepository,
      required OptionMenuRepository optionMenuRepository,
      required MenuRepository menuRepository,
      required CategoryRepository categoryRepository,
      required CloudStorage cloudStorage,
      required SecureStorage secureStorage,
      required AppSharedPref appSharedPref,
      required PenjualOrderRepository penjualOrderRepository,
      required AdminRepository adminRepository,
      required RatingRepository ratingRepository,
      required OrderRepository orderRepository,
      required AndroidNotificationChannel channel,
      required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      required MerchantRepository merchantRepository})

      //     : _authenticationRepository = authenticationRepository,
      // const App(
      //     {Key? key,
      //     required AuthenticationRepository authenticationRepository,
      //     required MenuRepository menuRepository,
      //     required AppSharedPref appSharedPref})
      : _authenticationRepository = authenticationRepository,
        _optionMenuRepository = optionMenuRepository,
        _menuRepository = menuRepository,
        _appSharedPref = appSharedPref,
        _categoryRepository = categoryRepository,
        _cloudStorage = cloudStorage,
        _secureStorage = secureStorage,
        _ratingRepository = ratingRepository,
        _orderRepository = orderRepository,
        _merchantRepository = merchantRepository,
        _adminRepository = adminRepository,
        _channel = channel,
        _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        _penjualOrderRepository = penjualOrderRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final MenuRepository _menuRepository;
  final AppSharedPref _appSharedPref;
  final CategoryRepository _categoryRepository;
  final OptionMenuRepository _optionMenuRepository;
  final CloudStorage _cloudStorage;
  final SecureStorage _secureStorage;
  final AndroidNotificationChannel _channel;
  final AdminRepository _adminRepository;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final RatingRepository _ratingRepository;
  final OrderRepository _orderRepository;
  final MerchantRepository _merchantRepository;
  final PenjualOrderRepository _penjualOrderRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((value) => null);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        widget._flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              widget._channel.id,
              widget._channel.name,
              channelDescription: widget._channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        widget._flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              widget._channel.id,
              widget._channel.name,
              channelDescription: widget._channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget._authenticationRepository),
        RepositoryProvider.value(value: widget._menuRepository),
        RepositoryProvider.value(value: widget._categoryRepository),
        RepositoryProvider.value(value: widget._secureStorage),
        RepositoryProvider.value(value: widget._cloudStorage),
        RepositoryProvider.value(value: widget._ratingRepository),
        RepositoryProvider.value(value: widget._orderRepository),
        RepositoryProvider.value(value: widget._merchantRepository),
        RepositoryProvider.value(value: widget._penjualOrderRepository),
        RepositoryProvider.value(value: widget._appSharedPref),
        RepositoryProvider.value(value: widget._optionMenuRepository),
        RepositoryProvider.value(value: widget._adminRepository),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(
          authenticationRepository: widget._authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusApp = context.select((AppBloc bloc) => bloc.state.status);
    return MaterialApp(
      theme: CFTheme.themeData,
      title: 'Cafetaria',
      home: statusApp == AppStatus.authenticated
          ? const PilihKwsn()
          : const LoginPage(),
    );
  }
}

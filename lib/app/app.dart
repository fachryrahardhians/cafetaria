import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';

import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:storage/storage.dart';


import 'package:sharedpref_repository/sharedpref_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required MenuRepository menuRepository,
    required CategoryRepository categoryRepository,
    required CloudStorage cloudStorage,
    required SecureStorage secureStorage,
    required AppSharedPref appSharedPref,
    required PenjualOrderRepository penjualOrderRepository,
  })
  //     : _authenticationRepository = authenticationRepository,
  // const App(
  //     {Key? key,
  //     required AuthenticationRepository authenticationRepository,
  //     required MenuRepository menuRepository,
  //     required AppSharedPref appSharedPref})
      : _authenticationRepository = authenticationRepository,
        _menuRepository = menuRepository,
        _appSharedPref = appSharedPref,
        _categoryRepository = categoryRepository,
        _cloudStorage = cloudStorage,
        _secureStorage = secureStorage,
        _penjualOrderRepository = penjualOrderRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final MenuRepository _menuRepository;
  final AppSharedPref _appSharedPref;
  final CategoryRepository _categoryRepository;
  final CloudStorage _cloudStorage;
  final SecureStorage _secureStorage;
  final PenjualOrderRepository _penjualOrderRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _menuRepository),
        RepositoryProvider.value(value: _categoryRepository),
        RepositoryProvider.value(value: _secureStorage),
        RepositoryProvider.value(value: _cloudStorage),
        RepositoryProvider.value(value: _appSharedPref),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CFTheme.themeData,
      title: 'Cafetaria',
      // theme: ThemeData(
      //   primarySwatch: Colors.red,
      //   fontFamily: GoogleFonts.ubuntu().fontFamily,
      // ),
      home: const LoginPage(),
    );
  }
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/Authentication/views/link_email.dart';
import 'package:cafetaria/feature/penjual/views/order_page/detail_order_page.dart';
import 'package:cafetaria/feature/penjual/views/order_page/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penjual_repository/penjual_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class App extends StatelessWidget {
  const App(
      {Key? key,
      required AuthenticationRepository authenticationRepository,
      required MenuRepository menuRepository,
      required AppSharedPref appSharedPref})
      : _authenticationRepository = authenticationRepository,
        _menuRepository = menuRepository,
        _appSharedPref = appSharedPref,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final MenuRepository _menuRepository;
  final AppSharedPref _appSharedPref;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _menuRepository),
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
      title: 'Cafetaria',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
      home: const OrderPage(),
    );
  }
}

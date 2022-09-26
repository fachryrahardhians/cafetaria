import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/bloc/app_bloc.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';
import 'package:cafetaria/feature/pembeli/views/pembeli_profile_page.dart';

import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:rating_repository/rating_repository.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:storage/storage.dart';

import 'package:sharedpref_repository/sharedpref_repository.dart';

class App extends StatelessWidget {
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
      required RatingRepository ratingRepository,
      required OrderRepository orderRepository,
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
        _penjualOrderRepository = penjualOrderRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final MenuRepository _menuRepository;
  final AppSharedPref _appSharedPref;
  final CategoryRepository _categoryRepository;
  final OptionMenuRepository _optionMenuRepository;
  final CloudStorage _cloudStorage;
  final SecureStorage _secureStorage;
  final RatingRepository _ratingRepository;
  final OrderRepository _orderRepository;
  final MerchantRepository _merchantRepository;
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
        RepositoryProvider.value(value: _ratingRepository),
        RepositoryProvider.value(value: _orderRepository),
        RepositoryProvider.value(value: _merchantRepository),
        RepositoryProvider.value(value: _penjualOrderRepository),
        RepositoryProvider.value(value: _appSharedPref),
        RepositoryProvider.value(value: _optionMenuRepository),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(
          authenticationRepository: _authenticationRepository,
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
          ? const PembeliDashboardPage()
          : const LoginPage(),
    );
  }
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/bloc/app_bloc.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';
import 'package:cafetaria/feature/penjual/views/penjual_dashboard_page.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';
import 'package:storage/storage.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required MenuRepository menuRepository,
    required AppSharedPref appSharedPref,
    required CategoryRepository categoryRepository,
    required CloudStorage cloudStorage,
    required MerchantRepository merchantRepository,
    required SecureStorage secureStorage,
    required PenjualOrderRepository penjualOrderRepository,
  })  : _authenticationRepository = authenticationRepository,
        _menuRepository = menuRepository,
        _categoryRepository = categoryRepository,
        _merchantRepository = merchantRepository,
        _appSharedPref = appSharedPref,
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
  final MerchantRepository _merchantRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _menuRepository),
        RepositoryProvider.value(value: _categoryRepository),
        RepositoryProvider.value(value: _secureStorage),
        RepositoryProvider.value(value: _cloudStorage),
        RepositoryProvider.value(value: _penjualOrderRepository),
        RepositoryProvider.value(value: _merchantRepository),
        RepositoryProvider.value(value: _appSharedPref),
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
        home: const PenjualDashboardPage());
  }
}

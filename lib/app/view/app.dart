import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/app/bloc/app_bloc.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';

import 'package:cafetaria/feature/penjual/views/penjual_dashboard_page.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:storage/storage.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required MenuRepository menuRepository,
    required CategoryRepository categoryRepository,
    required CloudStorage cloudStorage,
    required SecureStorage secureStorage,
  })  : _authenticationRepository = authenticationRepository,
        _menuRepository = menuRepository,
        _categoryRepository = categoryRepository,
        _cloudStorage = cloudStorage,
        _secureStorage = secureStorage,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final MenuRepository _menuRepository;
  final CategoryRepository _categoryRepository;
  final CloudStorage _cloudStorage;
  final SecureStorage _secureStorage;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _menuRepository),
        RepositoryProvider.value(value: _categoryRepository),
        RepositoryProvider.value(value: _secureStorage),
        RepositoryProvider.value(value: _cloudStorage),
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
          ? const PenjualDashboardPage()
          : const LoginPage(),
    );
  }
}

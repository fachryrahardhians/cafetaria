import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penjual_repository/penjual_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required MenuRepository menuRepository,
  })  : _authenticationRepository = authenticationRepository,
        _menuRepository = menuRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final MenuRepository _menuRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _menuRepository),
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
      home: const LoginPage(),
    );
  }
}

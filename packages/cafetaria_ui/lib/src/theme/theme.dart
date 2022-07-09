import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class CFTheme {
  /// Default `ThemeData` for Cafetaria UI.
  static final ThemeData themeData = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    appBarTheme: _appBarTheme,
    brightness: Brightness.light,
    primaryColor: CFColors.redPrimary,
    canvasColor: _backgroundColor,
    backgroundColor: _backgroundColor,
    scaffoldBackgroundColor: _backgroundColor,
    inputDecorationTheme: _inputDecorationTheme,
    buttonTheme: _buttonTheme,
    splashColor: Colors.transparent,
    disabledColor: CFColors.grey,
    errorColor: CFColors.redAccent,
    dialogTheme: _dialogTheme,
  );

  static const _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    elevation: 0,
  );

  static const _backgroundColor = Colors.white;

  static final _appBarTheme = AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
    color: CFColors.grey,
    iconTheme: IconThemeData(color: CFColors.redPrimary40),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: CFColors.grey90,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    fillColor: Colors.white,
  );

  static final _buttonTheme = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: CFColors.redPrimary,
    height: 48,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

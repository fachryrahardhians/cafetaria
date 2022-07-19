import 'package:cafetaria_ui/src/colors/colors.dart';
import 'package:flutter/material.dart';

class CFButton extends ElevatedButton {
  const CFButton({
    super.key,
    required super.onPressed,
    required super.child,
  });

  CFButton.primary({
    super.key,
    required Widget super.child,
    required super.onPressed,
  }) : super(
          style: ElevatedButton.styleFrom(
            primary: CFColors.redPrimary40,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            minimumSize: const Size(
              double.infinity,
              48,
            ),
          ),
        );
}

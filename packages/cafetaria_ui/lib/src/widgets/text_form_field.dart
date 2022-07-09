import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';

/// {@template cafetaria_text_form_field}
/// A Text field component that uses the material component [TextFormField].
/// All the underlaying props are available.
///
/// ```dart
/// CFTextFormField()
/// ```
/// {@endtemplate}
class CFTextFormField extends TextFormField {
  /// {@macro cafetaria_text_form_field}
  CFTextFormField({
    super.key,
    super.controller,
    super.initialValue,
    super.keyboardType,
    super.textCapitalization,
    InputDecoration decoration = const InputDecoration(),
    super.inputFormatters,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
    super.validator,
    super.onChanged,
    super.onFieldSubmitted,
    super.obscureText,
    super.autofocus,
    super.textInputAction,
    super.autocorrect,
    super.style,
    bool super.enabled = true,
    super.focusNode,
    super.onSaved,
  }) : super(
          decoration: decoration.copyWith(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(color: CFColors.grayscaleBlack50),
          ),
        );

  /// {@macro cafetaria_text_form_field}
  CFTextFormField.textArea({
    super.key,
    super.controller,
    super.initialValue,
    super.keyboardType,
    super.textCapitalization,
    InputDecoration super.decoration,
    super.inputFormatters,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
    super.validator,
    super.onChanged,
    super.onFieldSubmitted,
    super.obscureText,
    super.autofocus,
    super.textInputAction,
    super.autocorrect,
    super.style,
    bool super.enabled = true,
    super.focusNode,
    super.onSaved,
  });
}

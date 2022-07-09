import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ReusableButton1 extends StatelessWidget {
  const ReusableButton1({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  final String label;
  final Function() onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: OutlinedButton(
        child: Text(
          label,
          style: normalText.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 90),
            backgroundColor: backgroundColor ?? MyColors.red1,
            side: BorderSide(
              color: borderColor ?? MyColors.red1,
            ),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.borderColor,
    this.backgroundColor,
  }) : super(key: key);

  final String label;
  final Function() onPressed;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
        decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xffFEDED8),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(25), left: Radius.circular(25)),
            border: Border.all(
              color: borderColor ?? MyColors.red1,
            )),
        child: Text(
          label,
          style: normalText.copyWith(color: MyColors.red1),
        ),
      ),
    );
  }
}

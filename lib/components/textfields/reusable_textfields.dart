import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfield1 extends StatelessWidget {
  CustomTextfield1({Key? key, this.hint, this.label}) : super(key: key);

  String? hint;
  String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? ''.toUpperCase(),
            style: const TextStyle(fontSize: 12, color: MyColors.grey1),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 1,
                  ),
                ]),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

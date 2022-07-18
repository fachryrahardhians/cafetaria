import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfield1 extends StatelessWidget {
  CustomTextfield1({
    Key? key,
    this.hint,
    this.label,
    this.maxLine,
    this.suffix,
    this.controller,
    this.isObscure,
  }) : super(key: key);

  final String? hint;

  ///Hint digunakan untuk tulisan sebagai hint di dalam Textfield
  final String? label;

  ///Label digunakan untuk tulisan label diatas textfield
  final int? maxLine;

  ///MaxLine digunakan untuk mengatur tinggi textfield default secara
  ///hitungan baris
  final TextEditingController? controller;

  ///controller untuk Text Editing Controller
  final Widget? suffix;

  final bool? isObscure;

  ///suffix untuk widget yang ditempatkan di bagian belakang di dalam textfield

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (label ?? '').toUpperCase(),
            style: const TextStyle(fontSize: 12, color: MyColors.grey1,
                letterSpacing: 1.1),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
              controller: controller,
              maxLines: maxLine ?? 1,
              obscureText: isObscure ?? false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint ?? '',
                suffixIcon: suffix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextfield1 extends StatelessWidget {
  SearchTextfield1({
    Key? key,
    this.hint,
    this.suffix,
    this.controller,
  }) : super(key: key);

  String? hint;
  TextEditingController? controller;
  Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffCACCCF),
            ),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(25),
              right: Radius.circular(25),
            ),
          ),
          hintText: hint ?? '',
          suffix: suffix,
          prefixIcon: const Icon(
            Icons.search,
            color: MyColors.red1,
            size: 18,
          ),
        ),
      ),
    );
  }
}

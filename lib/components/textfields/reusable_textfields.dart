// ignore_for_file: must_be_immutable

import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfield1 extends StatelessWidget {
  const CustomTextfield1({
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
            style: const TextStyle(
                fontSize: 12, color: MyColors.grey1, letterSpacing: 1.1),
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

class CustomTextfield2 extends StatelessWidget {
  CustomTextfield2({
    Key? key,
    this.hint,
    this.label,
    this.maxLine,
    this.suffix,
    this.enable,
    this.controller,
  }) : super(key: key);

  String? hint;
  bool? enable;

  ///Hint digunakan untuk tulisan sebagai hint di dalam Textfield
  String? label;

  ///Label digunakan untuk tulisan label diatas textfield
  int? maxLine;

  ///MaxLine digunakan untuk mengatur tinggi textfield default secara
  ///hitungan baris
  TextEditingController? controller;

  ///controller untuk Text Editing Controller
  Widget? suffix;

  ///suffix untuk widget yang ditempatkan di bagian belakang di dalam textfield

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (label ?? '').toUpperCase(),
            style: const TextStyle(
                fontSize: 13,
                color: MyColors.grey1,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
            clipBehavior: Clip.antiAlias,
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
              enabled: enable,
              controller: controller,
              maxLines: maxLine ?? 1,
              decoration: InputDecoration(
                isDense: false,
                border: InputBorder.none,
                hintText: hint ?? '',
                hintStyle: const TextStyle(color: MyColors.grey2),
                suffix: suffix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownTextfield1 extends StatelessWidget {
  DropdownTextfield1({
    Key? key,
    this.value,
    this.onChanged,
    this.items,
    this.hint,
    this.label,
    this.maxLine,
    this.suffix,
    this.controller,
  }) : super(key: key);

  String? value;
  dynamic onChanged;
  List? items;

  String? hint;

  ///Hint digunakan untuk tulisan sebagai hint di dalam Textfield
  String? label;

  ///Label digunakan untuk tulisan label diatas textfield
  int? maxLine;

  ///MaxLine digunakan untuk mengatur tinggi textfield default secara
  ///hitungan baris
  TextEditingController? controller;

  ///controller untuk Text Editing Controller
  Widget? suffix;

  ///suffix untuk widget yang ditempatkan di bagian belakang di dalam textfield

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (label ?? '').toUpperCase(),
            style: const TextStyle(
                fontSize: 13,
                color: MyColors.grey1,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
            clipBehavior: Clip.antiAlias,
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
            child: DropdownButton(
                value: value,
                onChanged: onChanged,
                isExpanded: true,
                hint: Text(hint ?? "",
                    style: const TextStyle(color: MyColors.grey2)),
                style: const TextStyle(fontSize: 16, color: MyColors.grey2),
                underline: Container(),
                items: ['Hiburan', 'Two', 'Free', 'Four'].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
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

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
            style: const TextStyle(fontSize: 12, color: MyColors.grey1),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: Colors.white, boxShadow: [
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
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint ?? '',
                suffix: suffix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextfield1 extends StatelessWidget {
  const SearchTextfield1({
    Key? key,
    this.hint,
    this.suffix,
    this.controller,
  }) : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final Widget? suffix;

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

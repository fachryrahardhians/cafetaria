import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:flutter/material.dart';


class TestComponentTextfields extends StatelessWidget {
  const TestComponentTextfields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Textfields"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          CustomTextfield1(label: "NAMA MENU",hint: "Masukkan nama menu",),
        ],
      ),
    );
  }
}

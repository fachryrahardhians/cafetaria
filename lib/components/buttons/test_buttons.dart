import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:flutter/material.dart';

class TestButtons extends StatelessWidget {
  const TestButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Button"),
      ),
      body: Column(
        children: [
          ReusableButton1(label: "Coba", onPressed: () {}),
          CategoryButton(label: "Coba", onPressed: () {}),
        ],
      ),
    );
  }
}

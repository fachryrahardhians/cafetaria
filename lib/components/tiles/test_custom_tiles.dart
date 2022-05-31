import 'package:cafetaria/components/tiles/custom_tiles.dart';
import 'package:flutter/material.dart';

class TestCustomTiles extends StatelessWidget {
  const TestCustomTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Tiles"),
      ),
      body: ListView(
        children: [
          OrderCard(),
          DetailOrderCard(),
          CustomMenuOrderTile(),
        ],
      ),
    );
  }
}

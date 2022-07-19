import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    Key? key,
    required this.index,
    required this.menu,
  }) : super(key: key);

  final Map<String, dynamic> menu;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        // onTap: () => controller.checkSelected(menu, index),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 60,
                    width: 60,
                    child: Image.asset(menu["image"]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${menu['name']}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("${menu['price']}"),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.radio_button_checked,
                color: MyColors.red1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

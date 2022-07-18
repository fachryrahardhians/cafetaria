import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final MenuModel menu;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          print("SELECT MENU : ${menu.name}");
        },
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
                    child: Image.network(
                      menu.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${menu.name}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("${menu.price}"),
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

import 'package:cafetaria/feature/penjual/model/menu_model_obs.dart';
import 'package:cafetaria/feature/penjual/views/booking/controller/booking_controller.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemMenu extends StatelessWidget {
  ItemMenu({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final MenuModelObs menu;
  final bookC = Get.find<BookingController>();

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
          bookC.checkSelected(menu);
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
              Obx(
                () => Icon(
                  menu.selected.isTrue
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: menu.selected.isTrue ? MyColors.red1 : MyColors.grey3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

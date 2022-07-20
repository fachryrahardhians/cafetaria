import 'package:cafetaria/feature/penjual/views/widgets/item_menu.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class AturBookingPage extends StatelessWidget {
  const AturBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATUR BOOKING'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: MyColors.red1,
                        ),
                        hintText: "Cari diskon",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: MyColors.grey3,
                        backgroundImage: AssetImage("assets/icons/info.png"),
                      ),
                      SizedBox(width: 5),
                      Text("Pilih menu yang ingin diatur booking"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                // NASI AYAM
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: controller.dataMenuNasiAyam.length,
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    // Map<String, dynamic> menu = controller.dataMenuNasiAyam[index];
                    Map<String, dynamic> menu = {};
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            // "${menu['category'].toString().toUpperCase()}",
                            "{menu['category'].toString().toUpperCase()}",
                            style: TextStyle(
                              color: MyColors.grey3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ItemMenu(menu: menu, index: index),
                        ],
                      );
                    }
                    return ItemMenu(menu: menu, index: index);
                  },
                ),

                // MINUMAN
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    // Map<String, dynamic> menu = controller.dataMenuMinuman[index];
                    Map<String, dynamic> menu = {};
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            // "${menu['category'].toString().toUpperCase()}",
                            "{menu['category'].toString().toUpperCase()}",
                            style: TextStyle(
                              color: MyColors.grey3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ItemMenu(menu: menu, index: index),
                        ],
                      );
                    }
                    return ItemMenu(menu: menu, index: index);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // if (controller.issetSelected.isTrue) {
                  //   Get.toNamed(Routes.BOOKING_SETTING);
                  // }
                },
                child: const Text("PILIH MENU"),
                style: ElevatedButton.styleFrom(
                  primary: MyColors.disabledRed1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

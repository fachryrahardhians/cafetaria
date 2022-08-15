import 'package:cafetaria/feature/penjual/model/menu_model_obs.dart';
import 'package:cafetaria/feature/penjual/views/booking/booking_settings.dart';
import 'package:cafetaria/feature/penjual/views/booking/controller/booking_controller.dart';
import 'package:cafetaria/feature/penjual/views/booking/widgets/item_menu.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AturBookingPage extends StatelessWidget {
  AturBookingPage({Key? key, this.booking}) : super(key: key);

  final bookC = Get.find<BookingController>();

  final List<List<MenuModelObs>>? booking;

  @override
  Widget build(BuildContext context) {
    if (booking != null) {
      bookC.issetSelected.value = true;
    }
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
            child: FutureBuilder(
              future: bookC.getAllMenu(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: bookC.menu.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, indexAllMenu) {
                    List<MenuModelObs> menuByCategory = bookC.menu[indexAllMenu];
                    String categoryId = bookC.allCategoryMenu[indexAllMenu];

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: menuByCategory.length,
                      itemBuilder: (context, index) {
                        MenuModelObs menu = menuByCategory[index];
                        if (booking != null) {
                          booking!.forEach((e) {
                            e.forEach((element) {
                              if (element.menuId == menu.menuId) {
                                menu.selected.value = true;
                              }
                            });
                          });
                        }
                        if (index == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FutureBuilder<String>(
                                future: bookC.getCategoryName(categoryId),
                                builder: (context, snapCat) {
                                  if (snapCat.connectionState == ConnectionState.waiting) {
                                    return const Text(
                                      "LOADING...",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  return Text(
                                    snapCat.data!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              ItemMenu(menu: menu),
                            ],
                          );
                        }
                        return ItemMenu(menu: menu);
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (bookC.issetSelected.isTrue) {
                      if (booking != null) {
                        await bookC.editBooking();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Get.delete<BookingController>();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil mengubah booking")));
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookingSettingsPage(),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Wajib pilih menu"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: Text(booking != null ? "SIMPAN" : "PILIH MENU"),
                  style: ElevatedButton.styleFrom(
                    primary: bookC.issetSelected.isTrue ? MyColors.red1 : MyColors.disabledRed1,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

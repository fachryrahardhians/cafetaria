import 'package:cafetaria/feature/penjual/views/atur_booking_page.dart';
import 'package:cafetaria/feature/penjual/views/menu_cafetaria_page.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_info.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_order.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class PenjualDashboardPage extends StatelessWidget {
  const PenjualDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PenjualDashboardView();
  }
}

class PenjualDashboardView extends StatelessWidget {
  const PenjualDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "Halo Shabrina",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Ayam Pangeran - Gambir",
              style: TextStyle(color: MyColors.grey3),
            ),
            const SizedBox(height: 30),
            // Container Total Penjualan
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          "assets/icons/wallet.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total penjualan hari ini",
                            style: TextStyle(color: MyColors.white),
                          ),
                          RichText(
                            text: const TextSpan(
                              text: "Rp ",
                              children: [
                                TextSpan(
                                  text: "2.350.100",
                                  style: TextStyle(
                                    color: MyColors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "Dari kemarin",
                        style: TextStyle(color: MyColors.white),
                      ),
                      Text(
                        "Rp1.750.500",
                        style: TextStyle(color: MyColors.white),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/background.png"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 250 Pesanan
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "250 ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.blackText,
                    ),
                    children: [
                      TextSpan(
                        text: "Pesanan",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: MyColors.blackText,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  color: Colors.black,
                  width: 2,
                  height: 15,
                ),
                const SizedBox(width: 20),
                RichText(
                  text: const TextSpan(
                    text: "1.7K ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.blackText,
                    ),
                    children: [
                      TextSpan(
                        text: "Pembayaran QR",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: MyColors.blackText,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const MainMenuWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: MyColors.blackText,
        unselectedItemColor: MyColors.grey3,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset("assets/icons/bottom-home-active.png"),
            ),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset("assets/icons/bottom-pesan.png"),
            ),
            label: "Pesan",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset("assets/icons/bottom-history.png"),
            ),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset("assets/icons/bottom-profile.png"),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          // Icon Pesanan - Menu - Booking
          Row(
            children: [
              HomeItemOrder(
                route: () {
                  // print("Pesanan");
                },
                image: "assets/icons/paper.png",
                title: "Pesanan",
                total: 4,
              ),
              HomeItemOrder(
                route: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MenuCafetariaPage()));
                },
                image: "assets/icons/menu.png",
                title: "Menu",
              ),
              // TODO: SANDIKA
              HomeItemOrder(
                // route: () => Get.toNamed(
                //   Routes.BOOKING,
                //   arguments: controller.booking,
                // ),
                route: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AturBookingPage()));
                },
                image: "assets/icons/booking.png",
                title: "Atur Booking",
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "PAPAN INFO",
            style: TextStyle(color: MyColors.grey3),
          ),
          const SizedBox(height: 10),
          // Papan Info
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HomeItemInfo(
                  route: () => () {},
                  image: "assets/images/info-1.png",
                  title:
                      "Semua Petugas Ingat Protokol Kesehatan Ditempat Kerja",
                  author: "Charlie Natalie",
                ),
                HomeItemInfo(
                  route: () {},
                  image: "assets/images/info-2.png",
                  title: "Training Professional Tenant & Property Management",
                  author: "Charlie Natalie",
                ),
                HomeItemInfo(
                  route: () {},
                  image: "assets/images/info-1.png",
                  title:
                      "Semua Petugas Ingat Protokol Kesehatan Ditempat Kerja",
                  author: "Charlie Natalie",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

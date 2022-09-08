import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/penjual/views/booking/booking_page.dart';
import 'package:cafetaria/feature/penjual/views/menu_cafetaria_page.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_info.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_order.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PenjualDashboardPage extends StatelessWidget {
  const PenjualDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PenjualDashboardView();
  }
}

class PenjualDashboardView extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  PenjualDashboardView({Key? key}) : super(key: key);

  Future<Map<String, dynamic>?> getUser(AuthenticationRepository auth) async {
    User? user = await auth.getCurrentUser();

    if (user == null) {
      return null;
    } else {
      var merchantQuery = await firestore.collection("merchant").doc(user.uid).get();
      Map<String, dynamic>? store = merchantQuery.data();
      if (store == null) {
        return null;
      } else {
        return {
          "user": user,
          "store": store,
        };
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
          future: getUser(auth),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snap.data == null) {
              return const Center(
                child: Text("Tidak dapat data"),
              );
            }

            Map<String, dynamic> data = snap.data!;
            User user = data["user"];
            Map<String, dynamic> store = data["store"];

            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    "Halo ${user.displayName}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${store["name"]}",
                    style: const TextStyle(color: MyColors.grey3),
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
                                  text: TextSpan(
                                    text: "Rp ",
                                    children: [
                                      TextSpan(
                                        text: "${store["totalSalesToday"]}",
                                        style: const TextStyle(
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
                          children: [
                            const Text(
                              "Dari kemarin",
                              style: TextStyle(color: MyColors.white),
                            ),
                            Text(
                              "${store["totalSalesYesterday"]}",
                              style: const TextStyle(color: MyColors.white),
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
                        text: TextSpan(
                          text: "${store["totalOrderToday"]} ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.blackText,
                          ),
                          children: const [
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
                  MainMenuWidget(store["merchantId"]),
                ],
              ),
            );
          }),
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
  const MainMenuWidget(
    this.merchantId, {
    Key? key,
  }) : super(key: key);

  final String merchantId;

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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MenuCafetariaPage()));
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
                      builder: (_) => BookingPage(merchantId),
                    ),
                  );
                },
                image: "assets/icons/booking.png",
                title: "Atur Booking",
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';
import 'package:cafetaria/feature/penjual/bloc/merchant_bloc/bloc/merchant_bloc.dart';
import 'package:cafetaria/feature/penjual/views/booking/booking_page.dart';
import 'package:cafetaria/feature/penjual/views/menu_cafetaria_page.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_info.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_order.dart';
import 'package:cafetaria/feature/penjual_order/views/order_page/order_page.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharedpref_repository/sharedpref_repository.dart';

import '../../../firebase_options.dart';

class PenjualDashboardPage extends StatelessWidget {
  const PenjualDashboardPage({Key? key, this.id = ""}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MerchantBloc(
          merchantRepository: context.read<MerchantRepository>(),
          appSharedPref: context.read<AppSharedPref>())
        ..add(GetMerchant(id)),
      child: const PenjualDashboardView(),
    );
  }
}

//fungsi flutter background service
onStart() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final service = FlutterBackgroundService();
  final menurepository = MenuRepository(firestore: FirebaseFirestore.instance);

  //listen get data from ui or foreground
  service.onDataReceived.listen((event) {
    if (event?['action'] == 'stopService') {
      service.stopBackgroundService();
    }
  });

  //akan melakukan reload selama waktu atau duration yang diberikan
  Timer.periodic(const Duration(seconds: 10), (time) async {
    final idMerchant = await SharedPreferences.getInstance();
    List<MenuModel> data = await menurepository
        .getAllMenu(idMerchant.getString("merchantId").toString());
    //fungsi perulangan untuk mengecek tipe auto restok

    for (var i = 0; i < data.length; i++) {
      //mengecek jika data resetTime sama dengan null akan break fungsi
      if (data[i].resetTime.toString() == "" || data[i].resetTime!.isEmpty) {
        //print("Data time kosong");
        break;
      } else if ((data[i].resetType == 'jam') &&
          (DateTime.now().hour >=
              DateTime.parse(data[i].resetTime.toString()).hour)) {
        final docuser = FirebaseFirestore.instance
            .collection(
                'menuPerMerchant-${idMerchant.getString("merchantId").toString()}')
            .doc(data[i].menuId);
        docuser.update({
          'stock': data[i].defaultStock!,
          'resetTime': DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  DateTime.parse(data[i].resetTime!).hour + 1,
                  DateTime.now().minute)
              .toString()
        });
      } else if ((data[i].resetType == 'hari') &&
          ((DateTime.now().day >=
                  DateTime.parse(data[i].resetTime.toString()).day) &&
              (DateTime.now().hour >=
                  DateTime.parse(data[i].resetTime.toString()).hour))) {
        final docuser = FirebaseFirestore.instance
            .collection(
                'menuPerMerchant-${idMerchant.getString("merchantId").toString()}')
            .doc(data[i].menuId);
        docuser.update({
          'stock': data[i].defaultStock!,
          'resetTime': DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day + 1,
                  DateTime.parse(data[i].resetTime!).hour,
                  DateTime.now().minute)
              .toString()
        });
      } else if ((data[i].resetType == 'minggu') &&
          ((DateTime.now().day >=
                  DateTime.parse(data[i].resetTime.toString()).day) &&
              (DateTime.now().hour >=
                  DateTime.parse(data[i].resetTime.toString()).hour))) {
        final docuser = FirebaseFirestore.instance
            .collection(
                'menuPerMerchant-${idMerchant.getString("merchantId").toString()}')
            .doc(data[i].menuId);
        docuser.update({
          'stock': data[i].defaultStock!,
          'resetTime': DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day + 7,
                  DateTime.parse(data[i].resetTime!).hour,
                  DateTime.now().minute)
              .toString()
        });
      }
    }
  });
}

class PenjualDashboardView extends StatefulWidget {
  const PenjualDashboardView({Key? key}) : super(key: key);

  @override
  State<PenjualDashboardView> createState() => _PenjualDashboardViewState();
}

class _PenjualDashboardViewState extends State<PenjualDashboardView> {
  @override
  void initState() {
    super.initState();
    //menginisialisasi fungsi background service disaat app dibuka
    WidgetsFlutterBinding.ensureInitialized();
    FlutterBackgroundService.initialize(onStart);
    //context.read<AppSharedPref>().setMerchantId("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            BlocBuilder<MerchantBloc, MerchantState>(
              builder: (context, state) {
                final status = state.status;
                if (status == MerchantStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status == MerchantStatus.failure) {
                  return Center(
                    child: Text(state.error.toString()),
                  );
                } else if (status == MerchantStatus.success) {
                  final items = state.merchantModel;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Halo ${items?.name}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // const Text(
                      //   "Ayam Pangeran - Gambir",
                      //   style: TextStyle(color: MyColors.grey3),
                      // ),
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
                                            text: "${items?.totalSalesToday}",
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
                                  "Rp ${items?.totalSalesYesterday}",
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
                            text: TextSpan(
                              text: items?.totalOrderToday.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.blackText,
                              ),
                              children: const [
                                TextSpan(
                                  text: " Pesanan",
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
                      MainMenuWidget(merchantModel: items),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
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
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PembeliDashboardPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset("assets/icons/bottom-profile.png"),
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({Key? key, this.merchantModel}) : super(key: key);
  final MerchantModel? merchantModel;
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
                route: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const OrderPage()));
                  // print("Pesanan");
                },
                image: "assets/icons/paper.png",
                title: "Pesanan",
                total: merchantModel!.totalOrderToday!,
              ),
              HomeItemOrder(
                route: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MenuCafetariaPage(
                                idMerchant: merchantModel?.merchantId,
                              )));
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
                      builder: (_) => BookingPage(merchantModel!.merchantId!),
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

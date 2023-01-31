import 'dart:async';

import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/components/view_info.dart';
import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';
import 'package:cafetaria/feature/penjual/bloc/merchant_bloc/bloc/merchant_bloc.dart';
import 'package:cafetaria/feature/penjual/views/booking/booking_page.dart';
import 'package:cafetaria/feature/penjual/views/chat_list_merchant.dart';
import 'package:cafetaria/feature/penjual/views/menu_cafetaria_page.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_info.dart';

import 'package:cafetaria/feature/penjual/views/widgets/item_order.dart';
import 'package:cafetaria/feature/penjual_order/views/order_page/order_page.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharedpref_repository/sharedpref_repository.dart';

import '../../../firebase_options.dart';

class DahsboardPage extends StatelessWidget {
  int index;
  String id;
  DahsboardPage({Key? key, this.index = 0, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MerchantDashboard(id: id);
  }
}

class MerchantDashboard extends StatefulWidget {
  MerchantDashboard({Key? key, this.index = 0, required this.id})
      : super(key: key);
  int index;
  String id;
  @override
  State<MerchantDashboard> createState() => _MerchantDashboardState();
}

class _MerchantDashboardState extends State<MerchantDashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.index,
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(
            children: [
              PenjualDashboardPage(id: widget.id),
              ChatListMerchantWidget(id: widget.id),
              const SizedBox(),
              const SizedBox(),
            ],
          ),
          bottomNavigationBar: TabBar(
            indicator: const BoxDecoration(),
            labelColor: const Color(0xffee3124),
            unselectedLabelColor: const Color(0xffB1B5BA),
            unselectedLabelStyle: textStyle,
            labelStyle: textStyle,
            tabs: const [
              Tab(
                text: 'Home',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.home_filled),
              ),
              Tab(
                text: 'Pesan',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.mail_rounded,
                ),
              ),
              Tab(
                text: 'History',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.history,
                ),
              ),
              Tab(
                text: 'Profile',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.person_rounded,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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

//fungsi listing merchant menu
extension on List<QueryDocumentSnapshot> {
  List<MenuModel> toListMenu() {
    final leaderboardEntries = <MenuModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          leaderboardEntries.add(MenuModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}

//fungsi flutter background service
onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final service = FlutterBackgroundService();

  //listen get data from ui or foreground
  service.onDataReceived.listen((event) {
    if (event?['action'] == 'stopService') {
      service.stopBackgroundService();
    }
  });
  Future<List<MenuModel>> getAllMenu(
    String idMerchant,
  ) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('menuPerMerchant-$idMerchant')
          .get();

      final documents = snapshot.docs;
      return documents.toListMenu();
    } catch (e) {
      throw Exception('Failed to get All menu');
    }
  }

  //akan melakukan reload selama waktu atau duration yang diberikan
  Timer.periodic(const Duration(minutes: 30), (time) async {
    final idMerchant = await SharedPreferences.getInstance();
    List<MenuModel> data =
        await getAllMenu(idMerchant.getString("merchantId").toString());

    //fungsi perulangan untuk mengecek tipe auto restok
    for (var i = 0; i < data.length; i++) {
      //mengecek jika data resetTime sama dengan null akan break fungsi
      if (data[i].resetTime.toString() == "" || data[i].resetTime == null) {
        print("Data time kosong");
        //return;
        // break;
      } else {
        if (data[i].resetType == 'jam') {
          if ((DateTime.now().day >=
                  DateTime.parse(data[i].resetTime.toString()).day) &&
              (DateTime.now().hour >=
                  DateTime.parse(data[i].resetTime.toString()).hour)) {
            print("fungsi jam");
            final docuser = FirebaseFirestore.instance
                .collection('menu')
                .doc(data[i].menuId);
            docuser.update({
              'stock': data[i].defaultStock!,
              'resetTime': DateTime.parse(data[i].resetTime!)
                  .add(const Duration(hours: 1))
                  .toString()
            });
          } else {
            print("Data jam belum sesuai");
            //return;
          }
        } else if ((data[i].resetType == 'hari')) {
          if ((DateTime.now().year >=
                  DateTime.parse(data[i].resetTime.toString()).year) &&
              (DateTime.now().month >=
                  DateTime.parse(data[i].resetTime.toString()).month) &&
              (DateTime.now().day >=
                  DateTime.parse(data[i].resetTime.toString()).day) &&
              (DateTime.now().hour >=
                  DateTime.parse(data[i].resetTime.toString()).hour)) {
            print("fungsi hari");
            final docuser = FirebaseFirestore.instance
                .collection('menu')
                .doc(data[i].menuId);
            docuser.update({
              'stock': data[i].defaultStock!,
              'resetTime': DateTime.parse(data[i].resetTime!)
                  .add(const Duration(days: 1))
                  .toString()
            });
          } else {
            print("Data hari belum sesuai");
          }
        } else if ((data[i].resetType == 'minggu')) {
          if ((DateTime.now().year >=
                  DateTime.parse(data[i].resetTime.toString()).year) &&
              (DateTime.now().month >=
                  DateTime.parse(data[i].resetTime.toString()).month) &&
              (DateTime.now().day >=
                  DateTime.parse(data[i].resetTime.toString()).day) &&
              (DateTime.now().hour >=
                  DateTime.parse(data[i].resetTime.toString()).hour)) {
            print("fungsi minggu");
            final docuser = FirebaseFirestore.instance
                .collection('menu')
                .doc(data[i].menuId);
            docuser.update({
              'stock': data[i].defaultStock!,
              'resetTime': DateTime.parse(data[i].resetTime!)
                  .add(const Duration(days: 7))
                  .toString()
            });
          } else {
            print("Data minggu belum sesuai");
            return;
          }
        }
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/background.png"),
                          ),
                        ),
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PAPAN INFO',
                            style: textStyle.copyWith(
                                color: const Color(0xff808285)),
                          ),
                          Text(
                            'Lihat semua',
                            style: textStyle.copyWith(
                                fontSize: 12, color: const Color(0xffee3124)),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      StreamBuilder<List<InfoModel>>(
                        stream: context.read<AdminRepository>().getStreamInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Ada masalah ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            final items = snapshot.data;
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 5,
                              child: ListView.builder(
                                itemCount: items!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return items[index].status == "active"
                                      ? items[index].type == "penjual" ||
                                              items[index].type == "semua"
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => ViewInfo(
                                                            infoModel:
                                                                items[index])));
                                              },
                                              child: HomeItemInfo(
                                                image: items[index]
                                                    .image
                                                    .toString(),
                                                title: items[index]
                                                    .title
                                                    .toString(),
                                                author: 'Charlie Natalie',
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                      : const SizedBox.shrink();
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 10,
      //   selectedItemColor: MyColors.blackText,
      //   unselectedItemColor: MyColors.grey3,
      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 10),
      //         child: Image.asset("assets/icons/bottom-home-active.png"),
      //       ),
      //       label: "Beranda",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 10),
      //         child: Image.asset("assets/icons/bottom-pesan.png"),
      //       ),
      //       label: "Pesan",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 10),
      //         child: Image.asset("assets/icons/bottom-history.png"),
      //       ),
      //       label: "Riwayat",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: GestureDetector(
      //         onTap: () {
      //           Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (_) => const PembeliDashboardPage()));
      //         },
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(vertical: 10),
      //           child: Image.asset("assets/icons/bottom-profile.png"),
      //         ),
      //       ),
      //       label: "Profile",
      //     ),
      //   ],
      // ),
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

import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/components/view_info.dart';
import 'package:cafetaria/feature/admin/views/edit_kawasan.dart';
import 'package:cafetaria/feature/admin/views/home_info.dart';
import 'package:cafetaria/feature/admin/views/pending_sub_admin.dart';

import 'package:cafetaria/feature/admin/views/widgets/admin_page.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_info.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_order.dart';
import 'package:flutter/material.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeAdmin();
  }
}

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends AdminPage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(28),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Halo Admin Aplikasi",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Lapaku",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: MainMenu(),
              ),
              const SizedBox(height: 5),
              const Text(
                "PAPAN INFO",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 15),
              StreamBuilder<List<InfoModel>>(
                stream: getStreamInfo(),
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
                              ? items[index].type == "kawasan" ||
                                      items[index].type == "semua"
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewInfo(
                                                    infoModel: items[index])));
                                      },
                                      child: HomeItemInfo(
                                        image: items[index].image.toString(),
                                        title: items[index].title.toString(),
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
          )
        ],
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          // Icon Pesanan - Menu - Booking
          Row(
            children: [
              HomeItemOrder(
                route: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PendingSubAdmin()));
                },
                image: "assets/icons/pending.png",
                title: "Pending",
                total: 2,
              ),
              HomeItemOrder(
                route: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const EditKawasan()));
                },
                image: "assets/icons/admin_atur.png",
                title: "Atur Admin",
              ),
              HomeItemOrder(
                // route: () => Get.toNamed(
                //   Routes.BOOKING,
                //   arguments: controller.booking,
                // ),
                route: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HomeInfo()));
                },
                image: "assets/icons/atur_info.png",
                title: "Atur Info",
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

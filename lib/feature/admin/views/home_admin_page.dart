import 'package:cafetaria/feature/admin/views/tambah_info.dart';
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const HomeItemInfo(
                      image: 'assets/images/offer_1.png',
                      title:
                          'Semua Petugas Ingat Protokol Kesehatan Ditempat Kerja',
                      author: 'Charlie Natalie',
                    );
                  },
                ),
              )
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
                route: () async {},
                image: "assets/icons/pending.png",
                title: "Pending",
                total: 2,
              ),
              HomeItemOrder(
                route: () {},
                image: "assets/icons/admin_atur.png",
                title: "Atur Admin",
              ),
              // TODO: SANDIKA
              HomeItemOrder(
                // route: () => Get.toNamed(
                //   Routes.BOOKING,
                //   arguments: controller.booking,
                // ),
                route: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const TambahInfo()));
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

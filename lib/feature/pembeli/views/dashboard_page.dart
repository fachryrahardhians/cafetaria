import 'package:cafetaria/feature/pembeli/views/history_page.dart';
import 'package:cafetaria/feature/pembeli/views/merchant_page.dart';
import 'package:cafetaria/feature/pembeli/views/pembeli_profile_page.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';

class PembeliDashboardPage extends StatelessWidget {
  final int index;
  const PembeliDashboardPage({Key? key, this.index=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PembeliDashboard(index: index);
  }
}

class PembeliDashboard extends StatefulWidget {
  final int index;
  const PembeliDashboard({Key? key, this.index=0}) : super(key: key);

  @override
  State<PembeliDashboard> createState() => _PembeliDashboardState(index);
}

class _PembeliDashboardState extends State<PembeliDashboard> {
  int index;
  _PembeliDashboardState(this.index);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: index,
      child: SafeArea(
        child: Scaffold(
          body: const TabBarView(
            children: [
              MerchantPage(),
              SizedBox(),
              HistoryPage(),
              PembeliProfilePage(),
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

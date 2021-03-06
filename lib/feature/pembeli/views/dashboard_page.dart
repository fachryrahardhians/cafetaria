import 'package:cafetaria/feature/pembeli/views/history_page.dart';
import 'package:cafetaria/feature/pembeli/views/makanan_page.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';

class PembeliDashboardPage extends StatelessWidget {
  const PembeliDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PembeliDashboard();
  }
}

class PembeliDashboard extends StatefulWidget {
  const PembeliDashboard({Key? key}) : super(key: key);

  @override
  State<PembeliDashboard> createState() => _PembeliDashboardState();
}

class _PembeliDashboardState extends State<PembeliDashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: const TabBarView(
            children: [
              Makanan(),
              SizedBox(),
              HistoryPage(),
              SizedBox(),
            ],
          ),
          bottomNavigationBar: Container(
            height: SizeConfig.safeBlockVertical * 7,
            decoration: BoxDecoration(
              boxShadow: boxShadows,
              color: Colors.white,
            ),
            child: TabBar(
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
      ),
    );
  }
}

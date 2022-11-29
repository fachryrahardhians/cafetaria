import 'package:cafetaria/feature/admin/views/home_admin_page.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  final int index;
  const AdminDashboard({Key? key, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AdminDashboardPage();
  }
}

class AdminDashboardPage extends StatefulWidget {
  final int index;
  const AdminDashboardPage({Key? key, this.index = 0}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: const TabBarView(
            children: [
              HomeAdminPage(),
              SizedBox.shrink(),
              SizedBox.shrink(),
              SizedBox.shrink(),
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
                text: 'Beranda',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.home_filled),
              ),
              Tab(
                text: 'Pesan ',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.mail_rounded,
                ),
              ),
              Tab(
                text: 'Riwayat',
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
      initialIndex: widget.index,
    );
  }
}

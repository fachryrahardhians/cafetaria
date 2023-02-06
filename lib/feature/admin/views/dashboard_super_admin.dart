import 'package:admin_repository/admin_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_bloc.dart';
import 'package:cafetaria/feature/admin/bloc/admin_kawasan_bloc/admin_kawasan_bloc.dart';
import 'package:cafetaria/feature/admin/views/admin_profile_page.dart';
import 'package:cafetaria/feature/admin/views/home_admin_page.dart';
import 'package:cafetaria/feature/admin/views/home_super_admin_page%20.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class SuperAdminDashboard extends StatelessWidget {
  final int index;
  const SuperAdminDashboard({Key? key, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
              appSharedPref: context.read<AppSharedPref>()),
        ),
        BlocProvider(
          create: (context) => AdminKawasanBloc(
              adminRepository: context.read<AdminRepository>()),
        ),
      ],
      child: const SuperAdminDashboardPage(),
    );
  }
}

class SuperAdminDashboardPage extends StatefulWidget {
  final int index;
  const SuperAdminDashboardPage({Key? key, this.index = 0}) : super(key: key);

  @override
  State<SuperAdminDashboardPage> createState() =>
      _SuperAdminDashboardPageState();
}

class _SuperAdminDashboardPageState extends State<SuperAdminDashboardPage> {
  @override
  Widget build(BuildContext context) {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
    return DefaultTabController(
      length: 4,
      initialIndex: widget.index,
      child: SafeArea(
        child: FutureBuilder<User?>(
            future: auth.getCurrentUser(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              if (!snap.hasData) {
                return const SizedBox();
              }
              User user = snap.data!;
              return Scaffold(
                body: TabBarView(
                  children: [
                    HomeSuperAdmin(userId: user),
                    const SizedBox.shrink(),
                    const SizedBox.shrink(),
                    const AdminProfilePage(),
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
              );
            }),
      ),
    );
  }
}

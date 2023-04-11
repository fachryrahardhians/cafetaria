// ignore_for_file: file_names

import 'package:admin_repository/admin_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';

import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_bloc.dart';
import 'package:cafetaria/feature/admin/bloc/admin_kawasan_bloc/admin_kawasan_bloc.dart';
import 'package:cafetaria/feature/admin/views/edit_kawasan.dart';
import 'package:cafetaria/feature/admin/views/home_info.dart';
import 'package:cafetaria/feature/admin/views/pending_sub_admin.dart';
import 'package:cafetaria/feature/admin/views/pick_kawasan.dart';

import 'package:cafetaria/feature/penjual/views/widgets/item_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class HomeSuperAdminPage extends StatelessWidget {
  final User? userId;
  const HomeSuperAdminPage({Key? key, this.userId}) : super(key: key);

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
      child: HomeSuperAdmin(userId: userId),
    );
  }
}

class HomeSuperAdmin extends StatefulWidget {
  final User? userId;
  const HomeSuperAdmin({Key? key, this.userId}) : super(key: key);

  @override
  State<HomeSuperAdmin> createState() => _HomeSuperAdminState();
}

class _HomeSuperAdminState extends State<HomeSuperAdmin> {
  void isSuperAdmin(AppSharedPref appSharedPref, bool value) async {
    await appSharedPref.setSuperAdmin(value);
  }

  bool? _documentExists;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('admin-app')
        .doc(widget.userId?.uid.toString())
        .get()
        .then((DocumentSnapshot snapshot) {
      setState(() {
        _documentExists = snapshot.exists;
        if (!_documentExists!) {
          FirebaseAuth.instance.signOut();
          context.read<AppSharedPref>().setSuperAdmin(false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Anda Bukan Admin Aplikasi'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSharedPref appSharedPref = context.read<AppSharedPref>();
    isSuperAdmin(appSharedPref, true);
    context.read<AdminKawasanBloc>().add(GetAdmin(widget.userId!.uid));
    return BlocBuilder<AdminKawasanBloc, AdminKawasanState>(
      builder: (context, state) {
        final status = state.status;
        if (status == AdminKawasanStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (status == AdminKawasanStatus.failure) {
          return const Center(
            child: Text('Terjadi kesalahan'),
          );
        } else if (status == AdminKawasanStatus.success) {
          // ignore: prefer_is_empty
          final items = state.items?.subAdminKawasan?.length == 0
              ? state.items?.adminKawasan?.first
              : state.items?.subAdminKawasan?.first;
          return Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(28),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _documentExists == true
                          ? "Halo Admin Aplikasi"
                          : "Halo ${items?.name} Admin",
                      style: const TextStyle(
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MainMenu(
                          idKawasan: items!.kawasanId.toString(),
                          document: _documentExists,
                          visible:
                              state.items!.adminKawasan != null ? true : false),
                    ),
                    const SizedBox(height: 5),
                  ],
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  final bool? document;
  final String idKawasan;
  final bool? visible;
  const MainMenu(
      {Key? key, required this.idKawasan, this.visible = false, this.document})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          // Icon Pesanan - Menu - Booking
          Row(
            children: [
              Visibility(
                visible: visible!,
                child: HomeItemOrder(
                  route: () async {
                    if (document == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PickKawasan()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PendingSubAdmin(
                                    idKawasan: idKawasan,
                                    kawasan: "subAdminKawasan",
                                  )));
                    }
                  },
                  image: "assets/icons/pending.png",
                  title: "Pending",
                  total: 2,
                ),
              ),
              Visibility(
                visible: visible!,
                child: HomeItemOrder(
                  route: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const EditKawasan()));
                  },
                  image: "assets/icons/admin_atur.png",
                  title: "Atur Admin",
                ),
              ),
              HomeItemOrder(
                // route: () => Get.toNamed(
                //   Routes.BOOKING,
                //   arguments: controller.booking,
                // ),
                route: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HomeInfo(
                                idKawasan: idKawasan,
                              )));
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

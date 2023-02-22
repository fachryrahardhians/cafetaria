import 'package:admin_repository/admin_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/view_info.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_bloc.dart';
import 'package:cafetaria/feature/admin/bloc/admin_kawasan_bloc/admin_kawasan_bloc.dart';

import 'package:cafetaria/feature/admin/views/home_info.dart';
import 'package:cafetaria/feature/admin/views/pending_sub_admin.dart';

import 'package:cafetaria/feature/admin/views/widgets/admin_page.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_info.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_order.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class HomeAdminPage extends StatelessWidget {
  final String? userId;
  const HomeAdminPage({Key? key, this.userId}) : super(key: key);

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
      child: HomeAdmin(userId: userId),
    );
  }
}

class HomeAdmin extends StatefulWidget {
  final String? userId;
  const HomeAdmin({Key? key, this.userId}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends AdminPage {
  @override
  Widget build(BuildContext context) {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
    return FutureBuilder<User?>(
        future: auth.getCurrentUser(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (!snap.hasData) {
            return const SizedBox();
          }
          User user = snap.data!;
          // context.read<AdminRepository>().getUserAdmin(user.uid).then((value) {
          //   print("Admin Kawasan: ${value.adminKawasan}");
          //   print("Sub Admin Kawasan: ${value.subAdminKawasan}");
          // });

          context.read<AdminKawasanBloc>().add(GetAdmin(user.uid));
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
                final items = state.items!.adminKawasan != null
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
                            "Halo ${items?.name} Admin",
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
                                visible: state.items!.adminKawasan != null
                                    ? true
                                    : false),
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
                                  height:
                                      MediaQuery.of(context).size.height / 5,
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
                                                                infoModel: items[
                                                                    index])));
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
                      )
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        });
  }
}

class MainMenu extends StatelessWidget {
  final String idKawasan;
  final bool? visible;
  const MainMenu({
    Key? key,
    required this.idKawasan,
    this.visible = false,
  }) : super(key: key);
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PendingSubAdmin(
                                  idKawasan: idKawasan,
                                  kawasan: "subAdminKawasan",
                                )));
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
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const EditKawasan()));
                  },
                  image: "assets/icons/admin_atur.png",
                  title: visible == true ? "Atur Sub-Admin" : "Atur Admin",
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

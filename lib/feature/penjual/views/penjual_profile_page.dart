// ignore_for_file: unused_field

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_bloc.dart';
import 'package:cafetaria/feature/Authentication/views/pilih_kawasan.dart';
import 'package:cafetaria/feature/pembeli/views/register_sub_admin.dart';
import 'package:cafetaria/feature/penjual/views/edit_profile.dart';
import 'package:cafetaria/feature/penjual/views/set_operational.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/utilities/feedback.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/pembeli/views/create_merchant_page.dart';
import 'package:cafetaria/feature/penjual/views/penjual_dashboard_page.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class Merchant {
  String name;

  Merchant(this.name);
}

class PenjualProfilePage extends StatelessWidget {
  const PenjualProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
          authenticationRepository: context.read<AuthenticationRepository>(),
          appSharedPref: context.read<AppSharedPref>()),
      child: const PenjualProfileView(),
    );
  }
}

class PenjualProfileView extends StatefulWidget {
  const PenjualProfileView({Key? key}) : super(key: key);

  @override
  State<PenjualProfileView> createState() => _PenjualProfileState();
}

class _PenjualProfileState extends State<PenjualProfileView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<double?> _progressFuture;
  @override
  void initState() {
    super.initState();
    _progressFuture = context.read<AppSharedPref>().getProgress();
  }

  Widget _merchantBanner() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => snapshot.data!.exists
        //         ? DahsboardPage(
        //             id: user.uid,
        //           )
        //         : PembeliCreateMerchantPage(user),
        //   ),
        // );
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          Image(image: AssetImage(Assets.images.user.path)),
          const SizedBox(width: 18),
          const Text("Pembeli",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: MyColors.red1,
          )
        ],
      ),
    );
  }

  void _navigateToEditProfile(user) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfile(idMerchant: user.uid),
        ));
    if (result == 'refresh') {
      setState(() {
        _progressFuture = context.read<AppSharedPref>().getProgress();
      });
    }
  }

  void _navigateToSetOperational(user) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetOperational(merchantId: user.uid),
        ));
    if (result == 'refresh') {
      setState(() {
        _progressFuture = context.read<AppSharedPref>().getProgress();
      });
    }
  }

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
        return Scaffold(
          backgroundColor: MyColors.whiteGrey2,
          body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: SizeConfig.screenHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28, // Image radius,
                              backgroundColor: MyColors.grey3,
                              backgroundImage: NetworkImage(user.photoURL!),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${user.displayName}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${user.email}")
                              ],
                            )
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 14),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 12,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            height: 84,
                            child: _merchantBanner()),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<double?>(
                            future: _progressFuture,
                            builder: (context, snapshot) {
                              if (snapshot.data == 1) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 12,
                                        offset: const Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 124,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Pengaturan Toko sudah selesai ${snapshot.data == null ? "0%" : snapshot.data == 0.5 ? "50%" : "100%"}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                          "Lengkapi profil toko dan jam operasional terlebih dahulu agar toko dapat aktif.",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Pengaturan Toko kamu sudah ${snapshot.data == null ? "0%" : snapshot.data == 0.5 ? "50%" : "100%"}",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      LinearProgressIndicator(
                                        value: snapshot.data ?? 0,
                                        color: const Color.fromARGB(
                                            255, 4, 201, 250), //<-- SEE HERE
                                        backgroundColor:
                                            Colors.grey, //<-- SEE HERE
                                      ),
                                    ],
                                  ));
                            }),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Text("AKUN")),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Edit Profil",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  onPressed: () {}),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Ganti Kata Sandi",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  onPressed: () {}),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Ganti Nomor Ponsel",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  onPressed: () {}),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Ganti Email",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal)),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Text("PENGATURAN TOKO")),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Profil Toko",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal)),
                                ),
                                onPressed: () => _navigateToEditProfile(user),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Jam Operasional",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal)),
                                ),
                                onPressed: () =>
                                    _navigateToSetOperational(user),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Text("PENGATURAN KAWASAN")),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Ganti Kawasan",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PilihKwsn(merchant: true),
                                        ));
                                  }),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Daftar Sub-Admin Kawasan",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterSubAdmin(user: user),
                                        ));
                                  }),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 37,
                              child: TextButton(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Beri Saran",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FeedBackPage(userId: user.uid),
                                        ));
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

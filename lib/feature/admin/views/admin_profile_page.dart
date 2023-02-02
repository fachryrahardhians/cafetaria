import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_bloc.dart';

import 'package:cafetaria/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cafetaria/components/buttons/reusables_buttons.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
          authenticationRepository: context.read<AuthenticationRepository>(),
          appSharedPref: context.read<AppSharedPref>()),
      child: const AdminProfileView(),
    );
  }
}

class AdminProfileView extends StatefulWidget {
  const AdminProfileView({Key? key}) : super(key: key);

  @override
  State<AdminProfileView> createState() => _AdminProfileViewState();
}

class _AdminProfileViewState extends State<AdminProfileView> {
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                      const SizedBox(height: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Text("AKUN")),
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
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
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Padding(
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal: 8, vertical: 8),
                      //         child: Text("PENGATURAN KAWASAN")),
                      //     const SizedBox(height: 20),
                      //     SizedBox(
                      //       width: double.infinity,
                      //       child: TextButton(
                      //           child: const Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text("Ganti Kawasan",
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontWeight: FontWeight.normal)),
                      //           ),
                      //           onPressed: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) => const PilihKwsn(),
                      //                 ));
                      //           }),
                      //     ),
                      //     const SizedBox(height: 20),
                      //     SizedBox(
                      //       width: double.infinity,
                      //       child: TextButton(
                      //           child: const Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text("Daftar Sub-Admin Kawasan",
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontWeight: FontWeight.normal)),
                      //           ),
                      //           onPressed: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       RegisterSubAdmin(user: user),
                      //                 ));
                      //           }),
                      //     ),
                      //     const SizedBox(height: 20),
                      //   ],
                      // ),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ReusableButton1(
                          label: "KELUAR",
                          onPressed: () async {
                            await auth.signoutGoogle();
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.all(0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

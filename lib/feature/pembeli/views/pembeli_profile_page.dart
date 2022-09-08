import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/create_merchant_page.dart';
import 'package:cafetaria/feature/pembeli/widget/widget.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PembeliProfilePage extends StatelessWidget {
  const PembeliProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const PembeliProfileView(),
    );
  }
}

class PembeliProfileView extends StatelessWidget {
  const PembeliProfileView({Key? key}) : super(key: key);

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
          bottomNavigationBar: BottomBar(index: 3),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 84,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PembeliCreateMerchantPage(user),
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Image(
                              image: AssetImage(
                                  'assets/images/merchant_default_icon.png')),
                          SizedBox(width: 18),
                          Text("Buka Toko Gratis",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: MyColors.red1,
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ReusableButton1(
                      label: "KELUAR",
                      onPressed: () async {
                        await auth.signoutGoogle();
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
        );
      },
    );
  }
}

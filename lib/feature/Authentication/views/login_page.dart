import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';

import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_bloc.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_event.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_state.dart';
import 'package:cafetaria/feature/Authentication/views/pilih_kawasan.dart';
import 'package:cafetaria/feature/admin/views/dashboard_admin.dart';

import 'package:cafetaria/feature/pembeli/views/merchant_page.dart';
import 'package:cafetaria/gen/assets.gen.dart';
//import 'package:cafetaria/feature/Authentication/views/link_email.dart';

//import 'package:cafetaria/feature/pembeli/views/pembeli_profile_page.dart';

import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
          authenticationRepository: context.read<AuthenticationRepository>(),
          appSharedPref: context.read<AppSharedPref>()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String id2 = "jvEXR7kMx7RDbIuwfbVcTJ1pOhJ2";
  Dialog infoCart() {
    bool loading = false;
    bool obscureText = true;
    final TextEditingController password = TextEditingController();
    final TextEditingController email = TextEditingController();

    return Dialog(child: StatefulBuilder(builder: (context, setState) {
      return BlocProvider(
        create: (context) => AuthenticationBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
            appSharedPref: context.read<AppSharedPref>()),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Assets.images.login.path),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Masuk Dengan Email",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextfield2(
                label: "EMAIL",
                enable: true,
                hint: "Masukkan Email ",
                controller: email,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Password'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 13,
                      color: MyColors.grey1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                        blurRadius: 1,
                      ),
                    ]),
                child: TextFormField(
                  enabled: true,
                  controller: password,
                  maxLines: 1,
                  obscureText: !obscureText,
                  decoration: InputDecoration(
                    isDense: false,
                    border: InputBorder.none,
                    hintText: "Masukkan Password Lengkap",
                    hintStyle: const TextStyle(color: MyColors.grey2),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              // CustomTextfield2(
              //   label: "Password",
              //   enable: true,
              //   hint: "Masukkan nama Lengkap",
              //   controller: password,
              // ),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationStateLoading) {
                    setState(() {
                      loading = true;
                    });
                  }
                  if (state is AuthenticationStateSuccess) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        // builder: (context) => const HomePage(),
                        // builder: (context) => const LinkEmailPage(),
                        builder: (context) => const AdminDashboard(),
                        // builder: (context) => const PembeliDashboardPage(),
                      ),
                    );
                  }
                  if (state is AuthenticationStateError) {
                    setState(() {
                      loading = false;
                    });
                    final snackBar = SnackBar(
                      content: const Text("Email Atau Password Salah"),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  height: 44,
                                  margin: const EdgeInsets.only(right: 8),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(
                                            color: Colors.red,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              side: BorderSide.none)),
                                      onPressed: () {
                                        loading == true
                                            ? loading
                                            : Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "BATAL",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black.withOpacity(1)),
                                      )))),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  height: 44,
                                  margin: const EdgeInsets.only(left: 8),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xffee3124)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  side: BorderSide.none))),
                                      onPressed: () {
                                        loading == true
                                            ? loading
                                            : context
                                                .read<AuthenticationBloc>()
                                                .add(GetPasswordLogin(
                                                    email.text.toString(),
                                                    password.text.toString()));
                                      },
                                      child: Text(
                                        loading == true ? "Loading " : "MASUK",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white.withOpacity(1)),
                                      )))),
                        ],
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BoxLogo(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36),
                  child: Text(
                    "Selamat Datang Kembali di Lapaku!",
                    style: extraBigText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     // builder: (context) => const HomePage(),
                    //     // builder: (context) => const LinkEmailPage(),
                    //     builder: (context) => const AdminDashboard(),
                    //     // builder: (context) => const PembeliDashboardPage(),
                    //   ),
                    // );
                  },
                  child: Container(
                    width: 370,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 75, vertical: 14),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 1,
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/icons/subadmin.png'),
                        Text(
                          "Masuk Sebagai Admin Apps",
                          style: bigText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: ((context) {
                          return infoCart();
                        }));
                  },
                  child: Container(
                    width: 370,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 14),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 1,
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/icons/admin.png'),
                        Text(
                          "Masuk Sebagai Admin & Sub-Admin",
                          style: bigText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (ctx, state) {
                    if (state is AuthenticationStateSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => const HomePage(),
                          // builder: (context) => const LinkEmailPage(),
                          builder: (context) => const PilihKwsn(),
                          // builder: (context) => const PembeliDashboardPage(),
                        ),
                      );
                    }
                    if (state is AuthenticationStateError) {
                      final snackBar = SnackBar(
                        content: Text(state.error),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(GetGoogleAuthentication());
                    },
                    child: Container(
                      width: 370,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 14),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                              blurRadius: 1,
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/icons/anggota.png'),
                          Text(
                            "Masuk Sebagai Anggota",
                            style:
                                bigText.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 18),
                //   child: Text(
                //     "ATAU",
                //     style: extraBigText.copyWith(
                //         fontWeight: FontWeight.bold, color: MyColors.grey2),
                //   ),
                // ),
                // const CustomTextfield1(
                //   label: "Email",
                // ),
                // const CustomTextfield1(
                //   label: "Password",
                // ),
                // const SizedBox(
                //   height: 50,
                // ),
                // ReusableButton1(
                //   label: "MASUK",
                //   onPressed: () {
                //     // Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //         builder: (_) => PenjualDashboardPage(
                //     //               id: id2,
                //     //             )));
                //   },
                // ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Text(
                    "Login As Guest",
                    style: textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MerchantPage(
                                  id: "jDoNCWTG8EUNNJvSNPTJnFtDDj12",
                                )));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessLogin extends StatelessWidget {
  const SuccessLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        child: Center(
          child: Text("SUKSES LOGIN"),
        ),
      ),
    );
  }
}

class BoxLogo extends StatelessWidget {
  const BoxLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MyColors.red1,
            MyColors.red2,
          ],
        ),
      ),
    );
  }
}

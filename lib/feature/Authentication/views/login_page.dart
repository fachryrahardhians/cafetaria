import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_bloc.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_event.dart';
import 'package:cafetaria/feature/Authentication/bloc/authentication/authentication_state.dart';
import 'package:cafetaria/feature/Authentication/views/link_email.dart';

import 'package:cafetaria/feature/penjual/views/penjual_dashboard_page.dart';
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
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BoxLogo(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Text(
                  "Selamat Datang Kembali di Komplekku!",
                  style: extraBigText.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (ctx, state) {
                  if (state is AuthenticationStateSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // builder: (context) => const HomePage(),
                        builder: (context) => const LinkEmailPage(),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 90, vertical: 14),
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
                    child: Text(
                      "Masuk Dengan Google",
                      style: bigText.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  "ATAU",
                  style: extraBigText.copyWith(
                      fontWeight: FontWeight.bold, color: MyColors.grey2),
                ),
              ),
              CustomTextfield1(
                label: "Email",
              ),
              CustomTextfield1(
                label: "Password",
              ),
              const SizedBox(
                height: 50,
              ),
              ReusableButton1(
                label: "MASUK",
                onPressed: () {},
              ),
            ],
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
    return Scaffold(
      body: Container(
        child: const Center(
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

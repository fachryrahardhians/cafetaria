
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/Authentication/bloc/logout/logout_bloc.dart';
import 'package:cafetaria/feature/Authentication/bloc/logout/logout_event.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class ExtendPage extends StatelessWidget {
  const ExtendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LogoutBloc
      (authenticationRepository: context.read<AuthenticationRepository>(),
      appSharedPref: context.read<AppSharedPref>(),),child: const ExtendPageView
        (),);
  }
}


class ExtendPageView extends StatefulWidget {
  const ExtendPageView({Key? key}) : super(key: key);

  @override
  _ExtendPageViewState createState() => _ExtendPageViewState();
}

class _ExtendPageViewState extends State<ExtendPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // context.read<AuthenticationBloc>().add(
                //     GetGoogleAuthentication());
                context.read<LogoutBloc>().add(DoLogout());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => const HomePage(),
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 14),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all( Radius.circular(8)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                        blurRadius: 1,
                      ),
                    ]),
                child: Text("Log Out", style: bigText.copyWith
                  (fontWeight: FontWeight.bold),),
              ),
            ),
            // ReusableButton1(label: "Pembeli", onPressed: (){
            //   ///todo REDIRECT KE HALAMAN PEMBELI
            // }),
            // ReusableButton1(label: "Penjual", onPressed: (){
            //   ///todo REDIRECT KE HALAMAN PENJUAL
            // }),

          ],
        ),
      ),
    );
  }
}

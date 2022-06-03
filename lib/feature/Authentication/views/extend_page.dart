import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ExtendPage extends StatefulWidget {
  const ExtendPage({Key? key}) : super(key: key);

  @override
  _ExtendPageState createState() => _ExtendPageState();
}

class _ExtendPageState extends State<ExtendPage> {
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

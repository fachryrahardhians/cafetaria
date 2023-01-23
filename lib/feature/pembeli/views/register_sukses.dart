import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/Authentication/views/pilih_kawasan.dart';
import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterSukses extends StatefulWidget {
  const RegisterSukses({Key? key}) : super(key: key);

  @override
  State<RegisterSukses> createState() => _RegisterSuksesState();
}

class _RegisterSuksesState extends State<RegisterSukses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ill_wait.png', scale: 2),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Verifikasi Sedang Diproses",
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: const Color(
                  0xff333435,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text(
                "Harap tunggu sementara kami memverifikasi Identitas dan data kawasan Anda. Anda akan menerima panggilan telepon dari agen kami dalam waktu 1x24 jam.",
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              height: 50,
              child: ReusableButton1(
                label: "KEMBALI KE HOMEPAGE",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PembeliDashboardPage()),
                  );
                },
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

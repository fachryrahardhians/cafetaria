import 'package:cafetaria/feature/penjual/views/menu_cafetaria_page.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PenjualDashboardPage extends StatelessWidget {
  const PenjualDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PenjualDashboardView();
  }
}

class PenjualDashboardView extends StatelessWidget {
  const PenjualDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const DashboarAppbar(),
      ),
      body: ListView(
        children: const [
          CardMaskGroup(),
          MainMenuWidget(),
        ],
      ),
    );
  }
}

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MenuCafetariaPage()));
            },
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffE9EBEF),
                    ),
                  ),
                  child: const Icon(Icons.book),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Menu',
                  style: GoogleFonts.ubuntu(
                    color: const Color(0xff222222),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardMaskGroup extends StatelessWidget {
  const CardMaskGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width,
      height: 84,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        image: DecorationImage(
          image: AssetImage(Assets.images.maskgroup.path),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total penjualan hari ini',
              style: GoogleFonts.ubuntu(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboarAppbar extends StatelessWidget {
  const DashboarAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Halo Shabrina",
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: const Color(
              0xff333435,
            ),
          ),
        ),
        Text(
          "Ayam Pangeran - Gambir",
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: const Color(
              0xff808285,
            ),
          ),
        ),
      ],
    );
  }
}

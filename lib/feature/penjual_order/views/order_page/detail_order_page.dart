import 'package:cafetaria/components/tiles/custom_tiles.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DetailOrderPageView();
  }
}

class DetailOrderPageView extends StatelessWidget {
  const DetailOrderPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF9FAFB),
        elevation: 0,
        leading: const BackButton(
          color: MyColors.red1,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 24,
            ),
            child: Row(
              children: [
                Text(
                  "Detail Pesanan",
                  style: extraBigText.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const DetailOrderCard(),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                "DETAIL PELANGGAN",
                style: normalText.copyWith(
                    color: const Color(0xff8C8F93),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              childrenPadding: const EdgeInsets.symmetric(horizontal: 24),
              tilePadding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                detailPelangganTile(
                  name: "nama pelanggan",
                  value: "Salma Tahira",
                ),
                detailPelangganTile(
                  name: "nomor handphone",
                  value: "081397979797",
                ),
                detailPelangganTile(
                    name: "alamat",
                    value: "Apartemen Skyline Residence",
                    detail: "Tower A • Lantai 3A • Nomor 37"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column detailPelangganTile(
      {required String name, required String value, String? detail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name.toUpperCase(),
          style: normalText.copyWith(
              color: const Color(0xff8C8F93),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: normalText.copyWith(
            letterSpacing: 0.8,
          ),
        ),
        detail != null
            ? const SizedBox(
                height: 5,
              )
            : Container(),
        detail != null
            ? Text(
                detail,
                style: normalText.copyWith(
                  letterSpacing: 0.8,
                ),
              )
            : Container(),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

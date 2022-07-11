import 'package:cafetaria/components/tiles/custom_tiles.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailOrderPageView();
  }
}

class DetailOrderPageView extends StatelessWidget {
  const DetailOrderPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF9FAFB),
        elevation: 0,
        leading: BackButton(
          color: MyColors.red1,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.symmetric(
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
        physics: BouncingScrollPhysics(),
        children: [
          DetailOrderCard(),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                "DETAIL PELANGGAN",
                style: normalText.copyWith(
                    color: Color(0xff8C8F93),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              childrenPadding: EdgeInsets.symmetric(horizontal: 24),
              tilePadding: EdgeInsets.symmetric(horizontal: 24),
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
                  detail: "Tower A • Lantai 3A • Nomor 37"
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column detailPelangganTile({required String name, required String value,
    String? detail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name.toUpperCase(),
          style: normalText.copyWith(
              color: Color(0xff8C8F93),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: normalText.copyWith(
            letterSpacing: 0.8,
          ),
        ),
        detail != null ? SizedBox(
          height: 5,
        ) : Container(),
        detail != null ? Text(
          detail,
          style: normalText.copyWith(
            letterSpacing: 0.8,
          ),
        ) : Container(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

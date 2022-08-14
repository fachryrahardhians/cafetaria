import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            padding:
                const EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    offset: Offset(0, 0),
                    spreadRadius: 3,
                    blurRadius: 3,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    const CustomTileDateBox(),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cafetaria #1234567890",
                          style: bigText.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Apartemen Skyline Residence",
                          style: bigText,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Tower A • Lantai 3A • Nomor 37",
                          style: normalText,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Divider(),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "ka tolong diantar ke lantai 1A no 3 yah",
                  style: smallText.copyWith(color: MyColors.grey2),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: "Keterangan : ",
                        style: smallText.copyWith(color: MyColors.red1)),
                    TextSpan(
                        text: "Mohon maaf, Ayam sudah habis kami "
                            "rekomendasikan Nasi Iga Bakar dengan harga Rp25"
                            ".000. Terima kasih  kak.",
                        style: smallText.copyWith(color: MyColors.grey2))
                  ]),
                ),
              ],
            ),
          ),
          const Positioned(
            right: 0,
            top: 0,
            child: CustomTileTimeBadge(),
          )
        ],
      ),
    );
  }
}

class DetailOrderCard extends StatelessWidget {
  const DetailOrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              offset: Offset(0, 0),
              spreadRadius: 3,
              blurRadius: 3,
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              const CustomTileDateBox(),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cafetaria #1234567890",
                    style: bigText.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Apartemen Skyline Residence",
                    style: bigText,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Tower A • Lantai 3A • Nomor 37 ",
                    style: normalText.copyWith(
                        fontWeight: FontWeight.bold, color: MyColors.grey2),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomMenuOrderTile extends StatelessWidget {
  const CustomMenuOrderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "20x",
            style: TextStyle(fontSize: 13),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tteokbokki Regular",
                style: TextStyle(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                "Nasi",
                style: TextStyle(fontSize: 13, color: MyColors.grey2),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: "Catatan : ",
                      style: normalText.copyWith(color: MyColors.red1)),
                  TextSpan(
                      text: "Nanti saya ambil jam 9 ya kak",
                      style: normalText.copyWith(color: MyColors.grey2))
                ]),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rp.400.000",
                style: TextStyle(fontSize: 13),
              ),
              Text(
                "Rp.520.000",
                style: smallText.copyWith(
                    color: MyColors.grey2,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTileDateBox extends StatelessWidget {
  const CustomTileDateBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff808285),
              Color(0xff808285),
              Color(0xff333435),
            ],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Rab",
            style: normalText.copyWith(color: Colors.white),
          ),
          const Text(
            "13",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            "JUN",
            style: normalText.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CustomTileTimeBadge extends StatelessWidget {
  const CustomTileTimeBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
        color: MyColors.green1.withOpacity(0.3),
      ),
      child: Text(
        "3 Menit lalu",
        style: normalText.copyWith(color: MyColors.green1,fontWeight: FontWeight
            .bold),
      ),
    );
  }
}

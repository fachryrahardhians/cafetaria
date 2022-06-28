import 'package:cafetaria/feature/pembeli/data/model/order_model.dart';
import 'package:cafetaria/feature/pembeli/views/makanan_detail_page.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Makanan extends StatefulWidget {
  const Makanan({Key? key}) : super(key: key);

  @override
  _MakananState createState() => _MakananState();
}

class _MakananState extends State<Makanan> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff333435));
  TextStyle headlineStyle = const TextStyle(
      color: Color(0xff333435), fontSize: 20, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFCFBFC),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffee3124)),
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'CAFETARIA',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff333435)),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: Icon(Icons.history),
          )
        ],
        actionsIconTheme: const IconThemeData(color: Color(0xffee3124)),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PROMO HARI INI',
                  style: textStyle.copyWith(color: const Color(0xff808285)),
                ),
                Text(
                  'Lihat semua',
                  style: textStyle.copyWith(
                      fontSize: 12, color: const Color(0xffee3124)),
                )
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 2),
            promo(),
            SizedBox(height: SizeConfig.safeBlockVertical * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'REKOMENDASI UNTUKMU',
                  style: textStyle.copyWith(color: const Color(0xff808285)),
                ),
                Text(
                  'Lihat semua',
                  style: textStyle.copyWith(
                      fontSize: 12, color: const Color(0xffee3124)),
                )
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 2),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider<OrderNotifier>(
                          create: (_) => OrderNotifier(),
                          child: const MakananDetail(
                            title: 'Key-Pop Korean Street Food - Antapaa',
                          )))),
              child: outlet(
                  'assets/illustration/ill_cafetaria_banner1.png',
                  true,
                  'Key-Pop Korean Street Food - Antapaa',
                  '1.2 km',
                  '15 min',
                  '4.8 • 1rb+ rating'),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 3),
            outlet(
                'assets/illustration/ill_cafetaria_banner2.png',
                false,
                'Shabrina’s Kitchen - Gambir',
                'Lantai 1',
                'Cafetaria',
                '4.8 • 1rb+ rating'),
            SizedBox(height: SizeConfig.safeBlockVertical * 3),
            outlet(
                'assets/illustration/ill_cafetaria_banner2.png',
                true,
                'Shabrina’s Kitchen - Gambir',
                'Lantai 1',
                'Cafetaria',
                '4.8 • 1rb+ rating')
          ]),
    );
  }

  Widget outlet(String image, bool promo, String title, String distance,
      String time, String rating) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: SizeConfig.safeBlockHorizontal * 20,
            height: SizeConfig.safeBlockHorizontal * 20,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(.04)),
                  BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                      color: Colors.black.withOpacity(.08))
                ]),
          ),
          SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                promo
                    ? Text('PROMO',
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: const Color(0xffee3124)))
                    : const SizedBox(),
                SizedBox(height: SizeConfig.safeBlockVertical * .5),
                Text(title,
                    style: textStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff2E3032)),
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: SizeConfig.safeBlockVertical * .5),
                Text(
                  '$distance • $time',
                  style: textStyle.copyWith(
                      fontSize: 11, color: const Color(0xff5C5E61)),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * .5),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xffFFC400),
                    ),
                    const SizedBox(width: 2),
                    Text(rating,
                        style: textStyle.copyWith(
                            fontSize: 11, color: const Color(0xffB1B5BA)))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget promo() {
    return SizedBox(
      height: SizeConfig.safeBlockVertical * 23,
      //padding: EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/ads/offer_1.png',
                    height: SizeConfig.safeBlockVertical * 16),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                Text('Dapatkan Potongan\nhingga 25% untuk\nMenu Pilihan',
                    style: textStyle.copyWith(fontSize: 12))
              ],
            ),
            SizedBox(width: SizeConfig.safeBlockHorizontal * 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/ads/offer_2.png',
                    height: SizeConfig.safeBlockVertical * 16),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                Text('Beef burger atau\nchicken burger hanya\nRp10 ribu saja!',
                    style: textStyle.copyWith(fontSize: 12))
              ],
            ),
            SizedBox(width: SizeConfig.safeBlockHorizontal * 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/ads/offer_3.png',
                    height: SizeConfig.safeBlockVertical * 16),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                Text('Tokyo Belly Food of\nThe Day Hanya Rp 28\nRibu',
                    style: textStyle.copyWith(fontSize: 12))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cafetaria/feature/pembeli/views/makanan_detail_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/feature/pembeli/views/widget/promo_widget.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';

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

    return ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
        children: [
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          const Center(
            child: Text(
              'CAFETARIA',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff333435)),
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 4),
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
                    builder: (_) => const MerchantPage(
                          title: 'Key-Pop Korean Street Food - Antapani',
                        ))),
            child: outlet(
                Assets.images.illCafetariaBanner1.path,
                true,
                'Key-Pop Korean Street Food - Antapani',
                '1.2 km',
                '15 min',
                '4.8 • 1rb+ rating'),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          outlet(
              Assets.images.illCafetariaBanner2.path,
              false,
              'Shabrina’s Kitchen - Gambir',
              'Lantai 1',
              'Cafetaria',
              '4.8 • 1rb+ rating'),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          outlet(
              Assets.images.illCafetariaBanner2.path,
              true,
              'Shabrina’s Kitchen - Gambir',
              'Lantai 1',
              'Cafetaria',
              '4.8 • 1rb+ rating')
        ]);
  }
}

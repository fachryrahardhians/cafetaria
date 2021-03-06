import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';

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
              Image.asset(Assets.images.offer1.path,
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
              Image.asset(Assets.images.offer2.path,
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
              Image.asset(Assets.images.offer3.path,
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

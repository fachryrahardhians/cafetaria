import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';

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

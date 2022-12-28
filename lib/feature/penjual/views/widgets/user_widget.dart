import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';

Widget userwidget(String title, String email) {
  return IntrinsicHeight(
    child: Row(
      children: [
        const CircleAvatar(
          radius: 28, // Image radius,
          backgroundColor: MyColors.grey3,
          child: Icon(Icons.person_rounded,color: MyColors.red1,),
        ),
        SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: textStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff2E3032)),
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: SizeConfig.safeBlockVertical * .5),
              Text(
                email,
                style: textStyle.copyWith(
                    fontSize: 15, color: const Color(0xff5C5E61)),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

import 'package:cafetaria/components/alertdialog/alert_dialog_widget.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Rating();
  }
}

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffee3124)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'TITLE',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff333435)),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Bagaimana Makananmu?',
              style:
                  textStyle.copyWith(fontWeight: FontWeight.w500, height: 16)),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 5,
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                    child: Icon(
                      rating < index + 1
                          ? Icons.star_border_rounded
                          : Icons.star_rounded,
                      color: MyColors.yellow1,
                      size: 40,
                    )),
                separatorBuilder: (context, index) => const SizedBox(width: 5),
                itemCount: 5),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 7),
          const CustomTextfield1(
            label: 'CERITAKAN PENGALAMANMU LEBIH LENGKAP',
            hint: 'Ceritakan pengalamanmu lebih lengkap',
            maxLine: 4,
          )
        ],
      ),
      bottomNavigationBar: ReusableButton1(
        label: 'KIRIM',
        onPressed: () {
          var baseDialog = AlertDialogWait(
            image: Assets.images.illRate.path,
            title: 'Makanan Anda sedang diproses',
            message:
                'Harap menunggu notifikasi melalui app ketika makanan sudah siap untuk diantar atau dijemput.',
            buttonText: 'KEMBALI KE HOME',
          );
          showDialog(
              context: context, builder: (BuildContext context) => baseDialog);
        },
      ),
    );
  }
}

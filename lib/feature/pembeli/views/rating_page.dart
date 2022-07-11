import 'package:cafetaria/components/alertdialog/alert_dialog_widget.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/pembeli/bloc/add_rating_bloc/add_rating_bloc.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_repository/rating_repository.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddRatingBloc(
              ratingRepository: context.read<RatingRepository>(),
            ),
        child: const Rating());
  }
}

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int rating = 0;
  TextEditingController _reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isRatingValid = context.select(
      (AddRatingBloc bloc) =>
          bloc.state.ratingInput.pure ||
          (!bloc.state.ratingInput.pure && bloc.state.ratingInput.valid),
    );
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
      body:
          BlocBuilder<AddRatingBloc, AddRatingState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Bagaimana Makananmu?',
                style: textStyle.copyWith(
                    fontWeight: FontWeight.w500, height: 16)),
            Container(
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                  itemCount: 5),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 7),
            Container(
              decoration: BoxDecoration(boxShadow: boxShadows),
              child: CFTextFormField.textArea(
                controller: _reviewController,
                decoration: InputDecoration(
                  labelText: "CERITAKAN PENGALAMANMU LEBIH LENGKAP",
                  errorText:
                      !isRatingValid ? "Review tidak boleh kosong" : null,
                ),
                onChanged: (review) {
                  context.read<AddRatingBloc>().add(RatingChange(review));
                },
              ),
            ),
          ],
        );
      }),
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

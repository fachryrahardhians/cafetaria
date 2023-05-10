import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/alertdialog/alert_dialog_widget.dart';
import 'package:cafetaria/feature/pembeli/bloc/add_rating_bloc/add_rating_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:formz/formz.dart';
// import 'package:rating_repository/rating_repository.dart';

class FeedBackPage extends StatelessWidget {
  const FeedBackPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FeedBack();
  }
}

class FeedBack extends StatefulWidget {
  const FeedBack({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  int rating = 0;
  XFile? fotoReview;
  TextEditingController _reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'BERIKAN SARAN',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333435)),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Assets.images.feedback.path, scale: 0.8),
                Text('Seberapa puaskah Kamu dengan Lapaku?',
                    style: textStyle.copyWith(
                        fontWeight: FontWeight.w500, height: 5)),
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
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 5),
                      itemCount: 5),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 7),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('TULISKAN PENDAPATMU')),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                Container(
                  decoration: BoxDecoration(boxShadow: boxShadows),
                  child: CFTextFormField.textArea(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Tuliskan pendapatmu untuk kami',
                      errorText: _reviewController.value.text.isEmpty
                          ? "Review tidak boleh kosong"
                          : null,
                    ),
                    onChanged: (review) {},
                  ),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 4),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: const [
                        Text('KRIM GAMBAR'),
                        Text(
                          '*tidak wajib diisi',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )),
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                fotoReview != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: MyColors.whiteGrey1,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                                blurRadius: 1,
                              ),
                            ]),
                        child: Center(
                          child: Image.asset(fotoReview!.path),
                        ))
                    : GestureDetector(
                        onTap: () async {
                          ImagePicker imagePicker = ImagePicker();
                          final data = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            fotoReview = data;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 16,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.images.gallery.path,
                                  scale: 0.6,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'BUKA GALERI',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CFButton.primary(child: const Text('KIRIM'), onPressed: () {}),
            ));
  }
}

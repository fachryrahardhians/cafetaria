import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class AlertDialogWait extends StatelessWidget {
  final String title;
  final String message;
  final String image;
  final String buttonText;
  final VoidCallback? onPressAction;

  const AlertDialogWait(
      {Key? key,
      required this.title,
      required this.message,
      required this.buttonText,
      this.image = 'assets/illustration/ill_wait.png',
      this.onPressAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var headlineStyle = const TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: Color(0xff222222));

    var textStyle = const TextStyle(
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color(0xff808285),
    );
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Image.asset(image,
                  width: size.width * .5, fit: BoxFit.fitWidth)),
          Center(
            child: Text(
              title,
              style: headlineStyle.copyWith(height: 1.5, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Center(
            child: Text(
              message,
              style: textStyle.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          SizedBox(
            height: size.height * .055,
            width: size.width,
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffee3124)),
                    foregroundColor:
                        MaterialStateProperty.all(const Color(0xffee3124)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide.none))),
                onPressed: onPressAction,
                child: Text(
                  buttonText,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(1)),
                )),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

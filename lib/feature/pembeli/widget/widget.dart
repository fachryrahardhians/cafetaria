import 'package:cafetaria/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class UploadPhotoMerchant extends StatelessWidget {
  UploadPhotoMerchant({
    Key? key,
    required this.onTap,
    this.photo,
    this.label,
    this.hint = "UNGGAH FOTO",
  }) : super(key: key);

  XFile? photo;
  String? label;
  String hint;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label ?? "",
              style: const TextStyle(
                  fontSize: 13,
                  color: MyColors.grey1,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 300,
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
                  child: photo != null
                      ? Image.file(File(photo!.path), fit: BoxFit.contain)
                      : Text(hint),
                ))
          ],
        ));
  }
}

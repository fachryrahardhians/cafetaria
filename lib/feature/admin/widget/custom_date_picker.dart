import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final String? judul;
  final VoidCallback? onPressed;
  final DateTime? tanggal;
  const CustomDatePicker({Key? key, this.judul, this.onPressed, this.tanggal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (judul ?? "").toUpperCase(),
          style: const TextStyle(
              fontSize: 13, color: MyColors.grey1, fontWeight: FontWeight.bold),
        ),
        InkWell(
            onTap: onPressed,
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                      blurRadius: 1,
                    ),
                  ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(convertDateTime(tanggal!)),
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.red,
                    )
                  ]),
            )),
      ],
    );
  }

  String convertDateTime(DateTime dateTime) {
    String month;

    switch (dateTime.month) {
      case 1:
        month = 'Januari';
        break;
      case 2:
        month = 'Febuari';
        break;
      case 3:
        month = 'Maret';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'Mei';
        break;
      case 6:
        month = 'Juni';
        break;
      case 7:
        month = 'Juli';
        break;
      case 8:
        month = 'Agustus';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'Oktober';
        break;
      case 11:
        month = 'November';
        break;
      default:
        month = 'Desember';
    }

    return '${dateTime.day} $month ${dateTime.year}';
  }
}

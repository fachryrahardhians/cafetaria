import 'package:cafetaria/feature/admin/views/tambah_info.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

abstract class TambahInfoModel extends State<TambahInfoWidget> {
  quill.QuillController quillController = quill.QuillController.basic();
  TextEditingController judul = TextEditingController();
  DateTime terbit = DateTime.now();
  DateTime kadarluasa = DateTime.now();
  ImagePicker picker = ImagePicker();
  XFile? gambar;
  bool status = false;
  String selectedDropdown = 'semua';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("semua"), value: "semua"),
      const DropdownMenuItem(child: Text("Pembeli"), value: "pembeli"),
      const DropdownMenuItem(child: Text("Penjual"), value: "penjual"),
    ];
    return menuItems;
  }

  void pickTerbit() async {
    DateTime? pick = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      currentTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      theme: const DatePickerTheme(
        backgroundColor: MyColors.white,
      ),
    );

    if (pick != null) {
      setState(() {
        terbit = pick;
      });
    }
  }

  Future handleUpload() async {
    final XFile? photo =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    setState(() {
      gambar = photo;
    });
  }

  void pickKadarluasa() async {
    DateTime? pick = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      currentTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      theme: const DatePickerTheme(
        backgroundColor: MyColors.white,
      ),
    );

    if (pick != null) {
      setState(() {
        kadarluasa = pick;
      });
    }
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

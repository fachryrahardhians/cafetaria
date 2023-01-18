

import 'package:cafetaria/feature/admin/views/tambah_info.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

abstract class TambahInfoModel extends State<TambahInfoWidget> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  quill.QuillController quillController = quill.QuillController.basic();
  bool submitLoading = false;
  TextEditingController judul = TextEditingController();
  DateTime? terbit;
  DateTime? kadarluasa;
  ImagePicker picker = ImagePicker();
  XFile? gambar;
  bool status = false;
  String selectedDropdown = 'semua';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "semua", child: Text("semua")),
      const DropdownMenuItem(value: "pembeli", child: Text("Pembeli")),
      const DropdownMenuItem(value: "penjual", child: Text("Penjual")),
      const DropdownMenuItem(value: "kawasan", child: Text("Kawasan")),
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

  bool checkDisableButton() {
    if (judul.text.isEmpty) {
      return true;
    }
    if (terbit == null) {
      return true;
    }

    if (kadarluasa == null) {
      return true;
    }
    if (widget.infoModel != null) {
      return false;
    }
    if (gambar == null) {
      return true;
    }
    return false;
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
}

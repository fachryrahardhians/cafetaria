import 'dart:convert';

import 'package:cafetaria/feature/admin/views/tambah_info.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

abstract class TambahInfoModel extends State<TambahInfoWidget> {
  quill.QuillController quillController = quill.QuillController.basic();
  quill.QuillController quillController2 = quill.QuillController.basic();
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

  void saveJson() {
    var json = jsonEncode(quillController.document.toDelta().toJson());
    var retrive = jsonDecode(json);
    //String data = htmlEscape.convert(json);
    setState(() {
      quillController2 = quill.QuillController(
          document: quill.Document.fromJson(retrive),
          selection: const TextSelection.collapsed(offset: 0));
    });
    print(json.toString());
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

 
}

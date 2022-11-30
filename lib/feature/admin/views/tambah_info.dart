import 'dart:io';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/admin/models/tambah_info_model.dart';
import 'package:cafetaria/feature/admin/widget/custom_date_picker.dart';
import 'package:cafetaria/feature/pembeli/widget/widget.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class TambahInfo extends StatelessWidget {
  const TambahInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TambahInfoWidget();
  }
}

class TambahInfoWidget extends StatefulWidget {
  const TambahInfoWidget({Key? key}) : super(key: key);

  @override
  State<TambahInfoWidget> createState() => _TambahInfoWidgetState();
}

class _TambahInfoWidgetState extends TambahInfoModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("TAMBAH INFO"),
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: const Color(0xffFCFBFC),
          elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextfield2(
              label: "JUDUL INFO",
              enable: true,
              hint: "Masukkan Judul Info",
              controller: judul,
            ),
            const SizedBox(height: 7),
            CustomDatePicker(
              judul: "Tanggal Terbit",
              onPressed: () {
                pickTerbit();
              },
              tanggal: terbit,
            ),
            const SizedBox(height: 10),
            CustomDatePicker(
              judul: "Tanggal Kadarluasa",
              onPressed: () {
                pickKadarluasa();
              },
              tanggal: kadarluasa,
            ),
            const SizedBox(height: 10),
            Text(
              ("tipe info").toUpperCase(),
              style: const TextStyle(
                  fontSize: 13,
                  color: MyColors.grey1,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 57,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.0,
                ),
              ),
              child: DropdownButtonFormField(
                value: selectedDropdown,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.red,
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'Pilih di upload ',
                ),
                items: dropdownItems,
                onChanged: (val) {
                  setState(() {
                    selectedDropdown = val.toString();
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              ("Status Info").toUpperCase(),
              style: const TextStyle(
                  fontSize: 13,
                  color: MyColors.grey1,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListTile(
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Aktif'),
                    leading: Radio(
                      activeColor: Colors.red,
                      value: true,
                      groupValue: status,
                      onChanged: (val) {
                        setState(() {
                          status = true;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Tidak Aktif'),
                    leading: Radio(
                      activeColor: Colors.red,
                      value: false,
                      groupValue: status,
                      onChanged: (val) {
                        setState(() {
                          status = false;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            quill.QuillToolbar.basic(
                multiRowsDisplay: true,
                controller: quillController,
                iconTheme: const quill.QuillIconTheme(
                    iconSelectedFillColor: Colors.red,
                    iconSelectedColor: Colors.white)),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: MyColors.whiteGrey1,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                      blurRadius: 1,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: quill.QuillEditor.basic(
                    controller: quillController, readOnly: false),
              ),
            ),
            const SizedBox(height: 20),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height / 2.5,
            //   decoration: const BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(5)),
            //       color: MyColors.whiteGrey1,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey,
            //           offset: Offset(0, 0),
            //           spreadRadius: 0,
            //           blurRadius: 1,
            //         ),
            //       ]),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: quill.QuillEditor.basic(
            //         controller: quillController2, readOnly: true),
            //   ),
            // ),
            CustomBoxPicker(
                label: "UNGGAH BANNER",
                hint: "UNGGAH FOTO",
                icon: const Icon(
                  Icons.upload,
                  color: MyColors.red1,
                  size: 32,
                ),
                onTap: () => handleUpload(),
                child: gambar == null
                    ? null
                    : Image.file(File(gambar!.path), fit: BoxFit.contain)),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ReusableButton1(
                label: "KIRIM",
                onPressed: () {
                  saveJson();
                },
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                //  disabled: _checkDisableButton(),
                //loading: _submitLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

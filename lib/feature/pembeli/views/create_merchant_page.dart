// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_collection_literals, avoid_init_to_null

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/pembeli/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class PembeliCreateMerchantPage extends StatelessWidget {
  const PembeliCreateMerchantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PembeliCreateMerchantView();
  }
}

class PembeliCreateMerchantView extends StatefulWidget {
  const PembeliCreateMerchantView({Key? key}) : super(key: key);

  @override
  State<PembeliCreateMerchantView> createState() =>
      _PembeliCreateMerchantState();
}

class _PembeliCreateMerchantState extends State<PembeliCreateMerchantView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Completer<GoogleMapController> _mapController = Completer();
  List<Marker> _marker = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _namaUsaha = TextEditingController();
  final TextEditingController _kota = TextEditingController();
  final TextEditingController _kodePos = TextEditingController();
  final TextEditingController _alamatLengkap = TextEditingController();
  final TextEditingController _lokasiDetail = TextEditingController();

  final List<String> _listBidangUsaha = ["Hiburan", "Makanan", "Minuman"];
  LatLng? _latLngToko;
  String? _bidangUsaha = null;
  XFile? _fotoLuar;
  XFile? _fotoDalam;

  Future _handleMapTap(LatLng latLng) async {
    setState(() {
      _marker = [Marker(markerId: MarkerId("main"), position: latLng)];
      _latLngToko = latLng;
    });

    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 17,
    )));

    List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: "id");
    Placemark placemark = placemarks[0];

    _alamatLengkap.text =
        '${placemark.thoroughfare != null ? placemark.street : ""}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
  }

  Future _handleUpload(String type) async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    setState(() {
      if (type == "dalam") {
        _fotoDalam = photo;
      } else {
        _fotoLuar = photo;
      }
    });
  }

  Future _onSubmit() async {
    final uuid = Uuid().v4();

    try {
      var snapshotLuar = await _storage
          .ref()
          .child('images/merchant/photo_from_outside/$uuid.jpg')
          .putFile(File(_fotoLuar!.path));
      var snapshotDalam = await _storage
          .ref()
          .child('images/merchant/photo_from_inside/$uuid.jpg')
          .putFile(File(_fotoDalam!.path));

      var urlLuar = await snapshotLuar.ref.getDownloadURL();
      var urlDalam = await snapshotDalam.ref.getDownloadURL();

      final data = {
        'name': _namaUsaha.text,
        'category': _bidangUsaha,
        'city': _kota.text,
        'postal_code': _kodePos.text,
        'address': _alamatLengkap.text,
        'address_detail': _lokasiDetail.text,
        'address_latitude': _latLngToko!.latitude,
        'address_longitude': _latLngToko!.longitude,
        'photo_from_outside': urlLuar,
        'photo_from_inside': urlDalam
      };

      await _firestore.collection('merchant').doc(uuid).set(data);
      Fluttertoast.showToast(
          msg: "Submit success!", toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: "$error", toastLength: Toast.LENGTH_LONG);
    }
  }

  bool _checkDisableButton() {
    if (_namaUsaha.text.isEmpty) {
      return true;
    }
    if (_bidangUsaha == null) {
      return true;
    }
    if (_kota.text.isEmpty) {
      return true;
    }
    if (_kodePos.text.isEmpty) {
      return true;
    }
    if (_alamatLengkap.text.isEmpty) {
      return true;
    }
    if (_lokasiDetail.text.isEmpty) {
      return true;
    }
    if (_latLngToko == null) {
      return true;
    }
    if (_fotoLuar == null) {
      return true;
    }
    if (_fotoDalam == null) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.red),
        title: Text(
          "INFORMASI USAHA",
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: const Color(
              0xff333435,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  CustomTextfield2(
                    label: "NAMA USAHA",
                    hint: "Masukkan nama usaha",
                    controller: _namaUsaha,
                  ),
                  DropdownTextfield1(
                    label: "BIDANG USAHA",
                    hint: "Pilih bidang usaha",
                    value: _bidangUsaha,
                    items: _listBidangUsaha,
                    onChanged: (value) {
                      setState(() {
                        _bidangUsaha = value;
                      });
                    },
                  ),
                  CustomTextfield2(
                    label: "KOTA ATAU KABUPATEN",
                    hint: "Pilih kota",
                    controller: _kota,
                  ),
                  CustomTextfield2(
                    label: "KODE POS",
                    hint: "Masukkan kode pos",
                    controller: _kodePos,
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOKASI TOKO",
                        style: const TextStyle(
                            fontSize: 13,
                            color: MyColors.grey1,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          height: 300,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: GoogleMap(
                                  mapType: MapType.normal,
                                  mapToolbarEnabled: false,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(-6.200000, 106.816666),
                                    zoom: 12,
                                  ),
                                  myLocationEnabled: true,
                                  onTap: _handleMapTap,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _mapController.complete(controller);
                                  },
                                  markers: Set.from(_marker),
                                  gestureRecognizers: [
                                    Factory(() => EagerGestureRecognizer()),
                                  ].toSet())))
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextfield2(
                      label: "ALAMAT LENGKAP TOKO",
                      controller: _alamatLengkap,
                      maxLine: 4,
                      hint:
                          "Masukkan alamat lengkap toko dengan rt/rw, kel/des, dan kec"),
                  CustomTextfield2(
                    label: "LOKASI DETAIL",
                    hint: "Misalkan: Depan Circle K",
                    controller: _lokasiDetail,
                  ),
                  SizedBox(height: 10),
                  UploadPhotoMerchant(
                      label: "UNGGAH FOTO TOKO DARI LUAR",
                      onTap: () => _handleUpload("luar"),
                      photo: _fotoLuar),
                  SizedBox(height: 32),
                  UploadPhotoMerchant(
                      label: "UNGGAH FOTO TOKO DARI DALAM",
                      onTap: () => _handleUpload("dalam"),
                      photo: _fotoDalam),
                  SizedBox(height: 40),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ReusableButton1(
                          label: "SIMPAN",
                          onPressed: _onSubmit,
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          disabled: _checkDisableButton()))
                ],
              ))),
    );
  }
}

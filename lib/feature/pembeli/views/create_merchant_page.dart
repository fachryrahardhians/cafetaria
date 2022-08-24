// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_collection_literals, avoid_init_to_null

import 'dart:async';
import 'dart:io';

import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/pembeli/views/maps_picker_page.dart';
import 'package:cafetaria/feature/pembeli/widget/widget.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PembeliCreateMerchantPage extends StatelessWidget {
  const PembeliCreateMerchantPage(this.user, {Key? key}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return PembeliCreateMerchantView(user);
  }
}

class PembeliCreateMerchantView extends StatefulWidget {
  const PembeliCreateMerchantView(this.user, {Key? key}) : super(key: key);
  final User user;
  @override
  State<PembeliCreateMerchantView> createState() =>
      _PembeliCreateMerchantState();
}

class _PembeliCreateMerchantState extends State<PembeliCreateMerchantView> {
  late User user;
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
  LatLng _latLngInit = const LatLng(-6.200000, 106.816666);
  String? _bidangUsaha = null;
  XFile? _fotoLuar;
  XFile? _fotoDalam;

  bool _submitLoading = false;

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

  Future _handleMapsPicker() async {
    LatLng? latLng = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => MapsPickerPage(
                latLng: _latLngInit,
                marker: _marker,
              )),
    );

    if (latLng != null) {
      if (_latLngToko != null) {
        final GoogleMapController controller = await _mapController.future;
        controller.moveCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 17)));
      }

      setState(() {
        _marker = [Marker(markerId: const MarkerId("main"), position: latLng)];
        _latLngInit = latLng;
        _latLngToko = latLng;
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: "id");
      Placemark placemark = placemarks[0];

      _alamatLengkap.text =
          '${placemark.thoroughfare != null ? placemark.street : ""}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
    }
  }

  Future _onSubmit(context) async {
    final userId = user.uid;

    late String uuid;

    setState(() {
      _submitLoading = true;
    });

    try {
      final datas = {
        'userId': userId,
        'merchant': userId,
        'name': _namaUsaha.text,
        'category': _bidangUsaha,
        'city': _kota.text,
        'postal_code': _kodePos.text,
        'address': _alamatLengkap.text,
        'address_detail': _lokasiDetail.text,
        'address_latitude': _latLngToko!.latitude,
        'address_longitude': _latLngToko!.longitude,
        'rating': 0,
        'totalCountRating': 0,
        'totalOrderToday': 0,
        'totalSalesToday': 0,
        'totalSalesYesterday': 0,
        'create_at': Timestamp.now()
      };
      var documentReference =
          await _firestore.collection('merchant').add(datas);
      uuid = documentReference.id;

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
        'userId': userId,
        'merchant': userId,
        'name': _namaUsaha.text,
        'category': _bidangUsaha,
        'city': _kota.text,
        'postal_code': _kodePos.text,
        'address': _alamatLengkap.text,
        'address_detail': _lokasiDetail.text,
        'address_latitude': _latLngToko!.latitude,
        'address_longitude': _latLngToko!.longitude,
        'photo_from_outside': urlLuar,
        'photo_from_inside': urlDalam,
        'rating': 0,
        'totalCountRating': 0,
        'totalOrderToday': 0,
        'totalSalesToday': 0,
        'totalSalesYesterday': 0,
        'create_at': Timestamp.now()
      };

      await _firestore.collection('merchant').doc(userId).set(data);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Submit success!", toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: "$error", toastLength: Toast.LENGTH_LONG);
    } finally {
      setState(() {
        _submitLoading = false;
      });
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
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteGrey2,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
              const SizedBox(height: 10),
              CustomBoxPicker(
                  label: "LOKASI TOKO",
                  hint: "PILIH LOKASI",
                  icon: const Icon(
                    Icons.pin_drop,
                    color: MyColors.red1,
                    size: 32,
                  ),
                  onTap: _handleMapsPicker,
                  child: _latLngToko == null
                      ? null
                      : Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              mapToolbarEnabled: false,
                              myLocationEnabled: false,
                              zoomControlsEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: _latLngInit,
                                zoom: 17,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _mapController.complete(controller);
                              },
                              markers: Set.from(_marker),
                            ),
                            GestureDetector(
                                onTap: _handleMapsPicker,
                                child: Expanded(
                                    child: Container(
                                        color: Colors.black.withOpacity(0))))
                          ],
                        )),
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
              CustomBoxPicker(
                  label: "UNGGAH FOTO TOKO DARI LUAR",
                  hint: "UNGGAH FOTO",
                  icon: const Icon(
                    Icons.upload,
                    color: MyColors.red1,
                    size: 32,
                  ),
                  onTap: () => _handleUpload("luar"),
                  child: _fotoLuar == null
                      ? null
                      : Image.file(File(_fotoLuar!.path), fit: BoxFit.contain)),
              const SizedBox(height: 32),
              CustomBoxPicker(
                  label: "UNGGAH FOTO TOKO DARI DALAM",
                  hint: "UNGGAH FOTO",
                  icon: const Icon(
                    Icons.upload,
                    color: MyColors.red1,
                    size: 32,
                  ),
                  onTap: () => _handleUpload("dalam"),
                  child: _fotoDalam == null
                      ? null
                      : Image.file(File(_fotoDalam!.path),
                          fit: BoxFit.contain)),
              const SizedBox(height: 40),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ReusableButton1(
                      label: "SIMPAN",
                      onPressed: () {
                        _onSubmit(context);
                      },
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      disabled: _checkDisableButton(),
                      loading: _submitLoading))
            ],
          ),
        ),
      ),
    );
  }
}

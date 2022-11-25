import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/Authentication/views/kawasan_sukses.dart';
import 'package:cafetaria/feature/Authentication/views/pilih_kawasan.dart';
import 'package:cafetaria/feature/pembeli/views/maps_picker_page.dart';
import 'package:cafetaria/feature/pembeli/widget/widget.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class DaftarKawasan extends StatefulWidget {
  final User user;
  const DaftarKawasan({Key? key, required this.user}) : super(key: key);

  @override
  State<DaftarKawasan> createState() => _DaftarKawasanState();
}

class _DaftarKawasanState extends State<DaftarKawasan> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _namakawasan = TextEditingController();
  final TextEditingController _alamatLengkap = TextEditingController();
  LatLng? _latLngKawasan;
  final Completer<GoogleMapController> _mapController = Completer();
  List<Marker> _marker = [];
  LatLng _latLngInit = const LatLng(-6.200000, 106.816666);
  final _uuid = const Uuid();
  String? iduser;
  bool _submitLoading = false;
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
      if (_latLngKawasan != null) {
        final GoogleMapController controller = await _mapController.future;
        controller.moveCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 17)));
      }

      setState(() {
        _marker = [Marker(markerId: const MarkerId("main"), position: latLng)];
        _latLngInit = latLng;
        _latLngKawasan = latLng;
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: "id");
      Placemark placemark = placemarks[0];

      _alamatLengkap.text =
          '${placemark.thoroughfare != null ? placemark.street : ""}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
    }
  }

  bool _checkDisableButton() {
    if (_nama.text.isEmpty) {
      return true;
    }
    if (_namakawasan.text.isEmpty) {
      return true;
    }
    if (_alamatLengkap.text.isEmpty) {
      return true;
    }
    if (_email.text.isEmpty) {
      return true;
    }

    if (_latLngKawasan == null) {
      return true;
    }

    return false;
  }

  Future _onSubmit(context) async {
    //final userId = user.uid;
    String? idKawasan;
    setState(() {
      _submitLoading = true;
      idKawasan = _uuid.v4();
    });

    try {
      final data = {
        //'userId': userId,
        'address': _alamatLengkap.text,
        'name': _namakawasan.text,
        'adminId': iduser,
        'kawasanId': idKawasan,
        'kawasan_latitude': _latLngKawasan!.latitude,
        'kawasan_longitude': _latLngKawasan!.longitude,
      };

      await FirebaseFirestore.instance
          .collection('kawasan')
          .doc(idKawasan)
          .set(data);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const KawasanSukses()),
      );
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

  @override
  Widget build(BuildContext context) {
    _nama.text = widget.user.displayName!;
    _email.text = widget.user.email!;
    iduser = widget.user.uid;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Daftar KAWASAN",
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: const Color(
                0xff333435,
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  CustomTextfield2(
                    label: "Nama Lengkap",
                    enable: false,
                    hint: "Masukkan nama Lengkap",
                    controller: _nama,
                  ),
                  CustomTextfield2(
                    label: "EMAIL",
                    enable: false,
                    hint: "Masukkan Alamat Email",
                    controller: _email,
                  ),
                  // CustomTextfield2(
                  //   label: "NOMOR HANDPHONE",
                  //   //enable: false,
                  //   hint: "Masukkan nomor telepon anda",
                  //   controller: _nohp,
                  // ),
                  CustomTextfield2(
                    label: "NAMA KAWASAN",
                    //enable: false,
                    hint: "Masukkan Nama Kawasan",
                    controller: _namakawasan,
                  ),
                  CustomBoxPicker(
                      label: "LOKASI TOKO",
                      hint: "PILIH LOKASI",
                      icon: const Icon(
                        Icons.pin_drop,
                        color: MyColors.red1,
                        size: 32,
                      ),
                      onTap: _handleMapsPicker,
                      child: _latLngKawasan == null
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
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _mapController.complete(controller);
                                  },
                                  markers: Set.from(_marker),
                                ),
                                GestureDetector(
                                    onTap: _handleMapsPicker,
                                    child: Expanded(
                                        child: Container(
                                            color:
                                                Colors.black.withOpacity(0))))
                              ],
                            )),
                  const SizedBox(height: 20),
                  CustomTextfield2(
                      label: "ALAMAT LENGKAP KAWASAN",
                      controller: _alamatLengkap,
                      maxLine: 4,
                      hint:
                          "Masukkan alamat lengkap toko dengan rt/rw, kel/des, dan kec"),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ReusableButton1(
                      label: "DAFTAR",
                      onPressed: () {
                        _onSubmit(context);
                      },
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      disabled: _checkDisableButton(),
                      loading: _submitLoading,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

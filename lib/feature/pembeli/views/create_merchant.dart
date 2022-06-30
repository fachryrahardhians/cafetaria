// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_collection_literals, avoid_init_to_null

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/styles/colors.dart';

class PenjualDashboardPage extends StatelessWidget {
  const PenjualDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PenjualDashboardView();
  }
}

class PenjualDashboardView extends StatefulWidget {
  const PenjualDashboardView({Key? key}) : super(key: key);

  @override
  State<PenjualDashboardView> createState() => _PenjualDashboardState();
}

class _PenjualDashboardState extends State<PenjualDashboardView> {
  final Completer<GoogleMapController> _mapController = Completer();
  List<Marker> _marker = [];

  final List<String> _listBidangUsaha = ["Hiburan", "Makanan", "Minuman"];
  String? _bidangUsaha = null;

  void _handleMapTap(LatLng latLng) {
    setState(() {
      _marker = [Marker(markerId: MarkerId("main"), position: latLng)];
    });
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
              padding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 12),
              child: Column(
                children: [
                  CustomTextfield2(
                      label: "NAMA USAHA", hint: "Masukkan nama usaha"),
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
                      label: "KOTA ATAU KABUPATEN", hint: "Pilih kota"),
                  CustomTextfield2(
                      label: "KODE POS", hint: "Masukkan kode pos"),
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
                                    target: LatLng(
                                        37.42796133580664, -122.085749655962),
                                    zoom: 14.4746,
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
                      maxLine: 4,
                      hint:
                          "Masukkan alamat lengkap toko dengan rt/rw, kel/des, dan kec"),
                  CustomTextfield2(
                      label: "LOKASI DETAIL", hint: "Misalkan: Depan Circle K"),
                ],
              ))),
    );
  }
}

import 'dart:async';

import 'package:cafetaria/feature/Authentication/views/daftar_kawasan.dart';
import 'package:cafetaria/feature/pembeli/views/maps_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class DaftarKawasanModel extends State<DaftarKawasan> {
  final TextEditingController nama = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController nohp = TextEditingController();
  final TextEditingController namakawasan = TextEditingController();
  LatLng? latLngKawasan;
  LatLng latLngInit = const LatLng(-6.200000, 106.816666);
  List<Marker> marker = [];
  final Completer<GoogleMapController> mapController = Completer();
  bool submitLoading = false;
  Future handleMapsPicker() async {
    LatLng? latLng = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => MapsPickerPage(
                latLng: latLngInit,
                marker: marker,
              )),
    );

    if (latLng != null) {
      if (latLngKawasan != null) {
        final GoogleMapController controller = await mapController.future;
        controller.moveCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 17)));
      }

      setState(() {
        marker = [Marker(markerId: const MarkerId("main"), position: latLng)];
        latLngInit = latLng;
        latLngKawasan = latLng;
      });

      // List<Placemark> placemarks = await placemarkFromCoordinates(
      //     latLng.latitude, latLng.longitude,
      //     localeIdentifier: "id");
      // Placemark placemark = placemarks[0];

      // _alamatLengkap.text =
      //     '${placemark.thoroughfare != null ? placemark.street : ""}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
    }
  }

  bool checkDisableButton() {
    if (nama.text.isEmpty) {
      return true;
    }
    if (namakawasan.text.isEmpty) {
      return true;
    }
    if (nohp.text.isEmpty) {
      return true;
    }
    if (email.text.isEmpty) {
      return true;
    }

    if (latLngKawasan == null) {
      return true;
    }

    return false;
  }

  // Future _onSubmit(context) async {
  //   //final userId = user.uid;

  //   final GeoPoint data =
  //       GeoPoint(_latLngKawasan!.latitude, _latLngKawasan!.longitude);
  //   setState(() {
  //     _submitLoading = true;
  //   });

  //   try {
  //     final data = {
  //       //'userId': userId,
  //       'merchantId': userId,
  //       'name': _namaUsaha.text,
  //       'category': _bidangUsaha,
  //       'city': _kota.text,
  //       'createdAt': Timestamp.now()
  //     };

  //     await FirebaseFirestore.instance
  //         .collection('admin-kawasan')
  //         .doc(userId)
  //         .set(data);
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => PilihKawasan()),
  //     );
  //     Fluttertoast.showToast(
  //         msg: "Submit success!", toastLength: Toast.LENGTH_LONG);
  //   } catch (error) {
  //     Fluttertoast.showToast(msg: "$error", toastLength: Toast.LENGTH_LONG);
  //   } finally {
  //     setState(() {
  //       _submitLoading = false;
  //     });
  //   }
  // }

}

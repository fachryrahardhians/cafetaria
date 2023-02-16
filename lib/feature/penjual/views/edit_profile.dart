// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/pembeli/views/maps_picker_page.dart';
import 'package:cafetaria/feature/pembeli/widget/widget.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  final String idMerchant;
  const EditProfile({Key? key, required this.idMerchant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EditProfileWidget(
      idMerchant: idMerchant,
    );
  }
}

class EditProfileWidget extends StatefulWidget {
  final String idMerchant;
  const EditProfileWidget({Key? key, required this.idMerchant})
      : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Completer<GoogleMapController> _mapController = Completer();
  List<Marker> _marker = [];
  final TextEditingController namaUsaha = TextEditingController();
  final TextEditingController kota = TextEditingController();
  final TextEditingController kodePos = TextEditingController();
  final TextEditingController alamatLengkap = TextEditingController();
  final TextEditingController lokasiDetail = TextEditingController();
  LatLng? latLngToko;
  LatLng latLngInit = const LatLng(-6.200000, 106.816666);
  bool submitLoading = false;
  XFile? fotoBanner;
  bool checkDisableButton() {
    if (namaUsaha.text.isEmpty) {
      return true;
    }

    if (kota.text.isEmpty) {
      return true;
    }

    if (kodePos.text.isEmpty) {
      return true;
    }
    if (alamatLengkap.text.isEmpty) {
      return true;
    }
    if (lokasiDetail.text.isEmpty) {
      return true;
    }
    if (latLngToko == null) {
      return true;
    }

    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<MerchantRepository>()
        .getMerchantDetail(widget.idMerchant)
        .then((value) {
      namaUsaha.text = value.name!;
      kota.text = value.city!;
      kodePos.text = value.postal_code!;
      alamatLengkap.text = value.address!;
      latLngInit = LatLng(
          value.address_latitude!, value.address_longitude!);
      //latLngToko =  LatLng(snapshot.data!.address_latitude!, snapshot.data!.address_longitude!);
      lokasiDetail.text = value.address_detail!;
    });
  }

  Future _handleMapsPicker() async {
    LatLng? latLng = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => MapsPickerPage(
                latLng: latLngInit,
                marker: _marker,
              )),
    );

    if (latLng != null) {
      if (latLngToko != null) {
        final GoogleMapController controller = await _mapController.future;
        controller.moveCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 17)));
      }

      setState(() {
        _marker = [Marker(markerId: const MarkerId("main"), position: latLng)];
        latLngInit = latLng;
        latLngToko = latLng;
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: "id");
      Placemark placemark = placemarks[0];

      alamatLengkap.text =
          '${placemark.thoroughfare != null ? placemark.street : ""}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
    }
  }

  Future<XFile?> showImagePicker(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedFile;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from library'),
              onTap: () async {
                pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a picture'),
              onTap: () async {
                pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

    return pickedFile;
  }

  Future _onSubmit(context, String urlbanner) async {
    final userId = widget.idMerchant;

    setState(() {
      submitLoading = true;
    });

    try {
      var snapshotLuar = await _storage
          .ref()
          .child('images/merchant/images/$userId.jpg')
          .putFile(File(fotoBanner!.path));

      var urlLuar = fotoBanner == null
          ? urlbanner
          : await snapshotLuar.ref.getDownloadURL();

      final data = {
        'name': namaUsaha.text,
        'city': kota.text,
        'postal_code': kodePos.text,
        'address': alamatLengkap.text,
        'address_detail': lokasiDetail.text,
        'address_latitude':
            latLngToko == null ? latLngInit.latitude : latLngToko!.latitude,
        'address_longitude':
            latLngToko == null ? latLngInit.longitude : latLngToko!.longitude,
        'image': fotoBanner == null ? urlbanner : urlLuar,
      };

      await _firestore.collection('merchant').doc(userId).update(data);
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Submit success!", toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: "$error", toastLength: Toast.LENGTH_LONG);
    } finally {
      setState(() {
        submitLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Toko"),
        iconTheme: const IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<MerchantModel>(
        future: context
            .read<MerchantRepository>()
            .getMerchantDetail(widget.idMerchant),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Text("Error");
          } else {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  CustomTextfield2(
                    label: "NAMA USAHA",
                    hint: "Masukkan nama usaha",
                    controller: namaUsaha,
                  ),
                  CustomTextfield2(
                    label: "KOTA ATAU KABUPATEN",
                    hint: "Pilih kota",
                    controller: kota,
                  ),
                  CustomTextfield2(
                    label: "KODE POS",
                    hint: "Masukkan kode pos",
                    controller: kodePos,
                  ),
                  CustomTextfield2(
                      label: "ALAMAT LENGKAP TOKO",
                      controller: alamatLengkap,
                      maxLine: 4,
                      hint:
                          "Masukkan alamat lengkap toko dengan rt/rw, kel/des, dan kec"),
                  CustomBoxPicker(
                      label: "LOKASI TOKO",
                      hint: "PILIH LOKASI",
                      icon: const Icon(
                        Icons.pin_drop,
                        color: MyColors.red1,
                        size: 32,
                      ),
                      onTap: _handleMapsPicker,
                      child: latLngToko == null
                          ? null
                          : Stack(
                              children: [
                                GoogleMap(
                                  mapType: MapType.normal,
                                  mapToolbarEnabled: false,
                                  myLocationEnabled: false,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition: CameraPosition(
                                    target: latLngInit,
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
                                            color:
                                                Colors.black.withOpacity(0))))
                              ],
                            )),
                  const SizedBox(height: 20),
                  CustomTextfield2(
                    label: "LOKASI DETAIL",
                    hint: "Misalkan: Depan Circle K",
                    controller: lokasiDetail,
                  ),
                  CustomBoxPicker(
                      label: "UNGGAH FOTO TOKO DARI LUAR",
                      hint: "UNGGAH FOTO",
                      icon: const Icon(
                        Icons.upload,
                        color: MyColors.red1,
                        size: 32,
                      ),
                      onTap: () async {
                        final source = await showImagePicker(context);
                        setState(() {
                          fotoBanner = source;
                        });
                      },
                      child: fotoBanner == null
                          ? snapshot.data?.image != null
                              ? Image.network(snapshot.data!.image!,
                                  fit: BoxFit.contain)
                              : null
                          : Image.file(File(fotoBanner!.path),
                              fit: BoxFit.contain)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ReusableButton1(
                      label: "SIMPAN",
                      onPressed: () {
                        // _onSubmit(context);
                        _onSubmit(context, snapshot.data!.image!);
                      },
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      disabled: checkDisableButton(),
                      loading: submitLoading,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

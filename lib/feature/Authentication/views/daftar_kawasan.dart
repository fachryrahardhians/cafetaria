import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';

import 'package:cafetaria/feature/Authentication/widget/daftar_kawasan_model.dart';

import 'package:cafetaria/feature/pembeli/widget/widget.dart';
import 'package:cafetaria/styles/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DaftarKawasan extends StatefulWidget {
  const DaftarKawasan({Key? key}) : super(key: key);

  @override
  State<DaftarKawasan> createState() => _DaftarKawasanState();
}

class _DaftarKawasanState extends DaftarKawasanModel {
  @override
  Widget build(BuildContext context) {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
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
            "DAFTAR KAWASAN",
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: const Color(
                0xff333435,
              ),
            ),
          ),
        ),
        body: FutureBuilder<User?>(
          future: auth.getCurrentUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            if (!snap.hasData) {
              return const SizedBox();
            }
            User user = snap.data!;
            nama.text = user.displayName!;
            email.text = user.email!;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    children: [
                      CustomTextfield2(
                        label: "Nama Lengkap",
                        //enable: false,
                        hint: "Masukkan nama Lengkap",
                        controller: nama,
                      ),
                      CustomTextfield2(
                        label: "EMAIL",
                        enable: false,
                        hint: "Masukkan Alamat Email",
                        controller: email,
                      ),
                      CustomTextfield2(
                        label: "NOMOR HANDPHONE",
                        //enable: false,
                        hint: "Masukkan nomor telepon anda",
                        controller: nohp,
                      ),
                      CustomTextfield2(
                        label: "NAMA KAWASAN",
                        //enable: false,
                        hint: "Masukkan Nama Kawasan",
                        controller: namakawasan,
                      ),
                      CustomBoxPicker(
                          label: "LOKASI TOKO",
                          hint: "PILIH LOKASI",
                          icon: const Icon(
                            Icons.pin_drop,
                            color: MyColors.red1,
                            size: 32,
                          ),
                          onTap: handleMapsPicker,
                          child: latLngKawasan == null
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
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        mapController.complete(controller);
                                      },
                                      markers: Set.from(marker),
                                    ),
                                    GestureDetector(
                                        onTap: handleMapsPicker,
                                        child: Expanded(
                                            child: Container(
                                                color: Colors.black
                                                    .withOpacity(0))))
                                  ],
                                )),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ReusableButton1(
                          label: "DAFTAR",
                          onPressed: () {
                            //_onSubmit(context);
                          },
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.all(0),
                          disabled: checkDisableButton(),
                          loading: submitLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

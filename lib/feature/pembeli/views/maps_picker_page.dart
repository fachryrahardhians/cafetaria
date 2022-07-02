import 'package:flutter/material.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'dart:async';

class MapsPickerPage extends StatelessWidget {
  const MapsPickerPage({Key? key, required this.latLng, this.marker = const []})
      : super(key: key);

  final LatLng latLng;
  final List<Marker> marker;

  @override
  Widget build(BuildContext context) {
    return MapsPickerView(latLng: latLng, marker: marker);
  }
}

class MapsPickerView extends StatefulWidget {
  const MapsPickerView({Key? key, required this.latLng, this.marker = const []})
      : super(key: key);

  final LatLng latLng;
  final List<Marker> marker;

  @override
  State<MapsPickerView> createState() => _MapsPickerState();
}

class _MapsPickerState extends State<MapsPickerView> {
  final Completer<GoogleMapController> _mapController = Completer();
  List<Marker> _marker = [];
  LatLng? _latLng;

  @override
  void initState() {
    super.initState();
    _marker = widget.marker;
  }

  Future _handleMapTap(LatLng latLng) async {
    setState(() {
      _marker = [Marker(markerId: const MarkerId("main"), position: latLng)];
      _latLng = latLng;
    });

    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 17,
    )));
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
            "PILIH LOKASI",
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: const Color(
                0xff333435,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: GoogleMap(
                    mapType: MapType.normal,
                    mapToolbarEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: widget.latLng,
                      zoom: 12,
                    ),
                    myLocationEnabled: true,
                    onTap: _handleMapTap,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                    },
                    markers: Set.from(_marker),
                    gestureRecognizers: {
                  Factory(() => EagerGestureRecognizer()),
                })),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ReusableButton1(
                      label: "SIMPAN",
                      onPressed: () {
                        Navigator.pop(context, _latLng);
                      },
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      borderRadius: 0,
                      disabled: _latLng == null,
                    )))
          ],
        )

        // Stack(
        //   children: [
        //     Expanded(
        //         child: ),
        //     Positioned(
        //         bottom: 10,
        //         child: SizedBox(
        //             width: double.infinity,
        //             height: 50,
        //             child: ReusableButton1(
        //               label: "SIMPAN",
        //               onPressed: () {
        //                 Navigator.pop(context, _latLng);
        //               },
        //               padding: const EdgeInsets.all(0),
        //               margin: const EdgeInsets.all(0),
        //               disabled: _latLng == null,
        //             )))
        //   ],
        // )
        );
  }
}

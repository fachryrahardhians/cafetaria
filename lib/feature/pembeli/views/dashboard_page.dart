// ignore_for_file: avoid_print

import 'package:admin_repository/admin_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'package:cafetaria/feature/Authentication/bloc/bloc/pilih_kawasan_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/history_page.dart';
import 'package:cafetaria/feature/pembeli/views/merchant_page.dart';
import 'package:cafetaria/feature/pembeli/views/pembeli_profile_page.dart';

import 'package:cafetaria/styles/text_styles.dart';
import 'package:category_repository/category_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../gen/assets.gen.dart';
import '../../../styles/colors.dart';

class PembeliDashboardPage extends StatelessWidget {
  final int index;
  const PembeliDashboardPage({Key? key, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PembeliDashboard(index: index);
  }
}

class PembeliDashboard extends StatefulWidget {
  final int index;
  const PembeliDashboard({Key? key, this.index = 0}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<PembeliDashboard> createState() => _PembeliDashboardState(index);
}

class _PembeliDashboardState extends State<PembeliDashboard> {
  int index;
  String? id;
  String? lat;
  String? long;

  _PembeliDashboardState(this.index);
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Service Disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Service denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location Service permanently denied cannot request permission");
    }
    return await Geolocator.getCurrentPosition();
  }

  //listen for location update
  void _liveLocation() async {
    SharedPreferences latlang = await SharedPreferences.getInstance();
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 1000);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      print("Latitude : $lat");
      print("Longitude : $long");
      context.read<AuthenticationRepository>().getCurrentUser().then((value) {
        context.read<AdminRepository>().updateLongLat(
            value!.uid.toString(), long.toString(), lat.toString());
      });
      if ((position.latitude < latlang.getDouble('lat')! + -0.1) ||
              (position.latitude > latlang.getDouble('lat')! + 0.1)
          // && latlang.getDouble('lat')! < latlang.getDouble('lat')! + -0.1000000
          ) {
        showAlert(context);
        latlang.setDouble('lat', position.latitude);
        print("lat 2 : ${latlang.getDouble('lat')}");
      } else {
        print("data sama");
      }
    });
  }

  void showAlert(BuildContext context) {
    showDialog(context: context, builder: (context) => dialogChangeKawasan());
  }

  calculateDistance(List<PilihKawasanModel> model) {
    List<double> totalDistance = [];
    PilihKawasanModel? data;
    var i = 0;
    double? kawasan;
    while (i < model.length) {
      final double distance = Geolocator.distanceBetween(
          double.parse(lat.toString()),
          double.parse(long.toString()),
          double.parse(model[i].kawasan_latitude.toString()),
          double.parse(model[i].kawasan_longitude.toString()));
      totalDistance.add(distance);
      print(distance);
      i++;
    }

    for (var i = 0; i < totalDistance.length - 1; i++) {
      for (var j = 0; j < totalDistance.length; j++) {
        if (totalDistance[j] < totalDistance[i]) {
          kawasan = totalDistance[j];
          data = model[j];
        }
      }

      // if (totalDistance[a] < totalDistance[i]) {
      //   kawasan = totalDistance[a];
      //   data = model[a];

      // } else {
      //   kawasan = totalDistance[i];
      //   data = model[i];

      // }

    }
    print("Kawasan terdekat : $kawasan");
    return data;
  }

  Dialog dialogChangeKawasan() {
    return Dialog(
        child: BlocProvider(
      create: (context) => PilihKawasanBloc(
          categoryRepository: context.read<CategoryRepository>())
        ..add(const GetPilihKawasan()),
      child: BlocBuilder<PilihKawasanBloc, PilihKawasanState>(
        builder: (context, state) {
          final status = state.status;
          if (status == PilihKawasanStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (status == PilihKawasanStatus.failure) {
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          } else if (status == PilihKawasanStatus.success) {
            final items = state.items!;
            PilihKawasanModel model = calculateDistance(items);
            context
                .read<PilihKawasanBloc>()
                .add(KawasanChange(model.kawasanId.toString()));
            return Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 15, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.images.icMap.image(),
                  Text(
                    "Kamu Memasuki Kawasan Lapaku ${model.name}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Color(0xff222222),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(
                      "Apakah kamu ingin mengubah kawasan ke ${model.name}?",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff808285),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              height: 44,
                              margin: const EdgeInsets.only(right: 8),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: MyColors.red1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          side: BorderSide.none)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "TIDAK",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(1)),
                                  )))),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 44,
                            margin: const EdgeInsets.only(left: 8),
                            child: BlocConsumer<PilihKawasanBloc,
                                PilihKawasanState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColors.red1,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            side: BorderSide.none)),
                                    onPressed: () {
                                      context
                                          .read<PilihKawasanBloc>()
                                          .add(UpdateKawasan(id.toString()));
                                    },
                                    child: Text(
                                      "Ya Ganti",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white.withOpacity(1)),
                                    ));
                              },
                              listener: (context, state) {
                                if (state.inputStatus ==
                                    FormzStatus.submissionSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Status Berhasil Di Update'),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                } else if (state.inputStatus ==
                                    FormzStatus.submissionFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Terjadi kesalahan'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ))
                    ],
                  )
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ));
  }

  @override
  void initState() {
    _getCurrentLocation().then((value) async {
      SharedPreferences latlang = await SharedPreferences.getInstance();
      setState(() {
        lat = value.latitude.toString();
        long = value.longitude.toString();
        if (latlang.getDouble('lat') == null) {
          latlang.setDouble('lat', value.latitude);
        } else {
          print("data lat : ${latlang.getDouble('lat')! + 0.1}");
        }
      });
      _liveLocation();
    });
    context.read<AuthenticationRepository>().getCurrentUser().then((value) {
      setState(() {
        id = value?.uid;
      });

      context.read<AuthenticationRepository>().getFcmToken().then((value) {
        context
            .read<MenuRepository>()
            .updateFcmToken(id.toString(), value.toString());
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (lat != null && long != null) {
      context
          .read<AdminRepository>()
          .updateLongLat(id.toString(), long.toString(), lat.toString());
    }
    return DefaultTabController(
      length: 4,
      initialIndex: index,
      child: SafeArea(
        child: Scaffold(
          body: const TabBarView(
            children: [
              MerchantPage(),
              SizedBox(),
              HistoryPage(),
              PembeliProfilePage(),
            ],
          ),
          bottomNavigationBar: TabBar(
            indicator: const BoxDecoration(),
            labelColor: const Color(0xffee3124),
            unselectedLabelColor: const Color(0xffB1B5BA),
            unselectedLabelStyle: textStyle,
            labelStyle: textStyle,
            tabs: const [
              Tab(
                text: 'Home',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.home_filled),
              ),
              Tab(
                text: 'Pesan',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.mail_rounded,
                ),
              ),
              Tab(
                text: 'History',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.history,
                ),
              ),
              Tab(
                text: 'Profile',
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.person_rounded,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

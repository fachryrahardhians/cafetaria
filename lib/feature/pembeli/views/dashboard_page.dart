// ignore_for_file: avoid_print

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/pembeli/views/history_page.dart';
import 'package:cafetaria/feature/pembeli/views/merchant_page.dart';
import 'package:cafetaria/feature/pembeli/views/pembeli_profile_page.dart';

import 'package:cafetaria/styles/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:menu_repository/menu_repository.dart';

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
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      print("Latitude : $lat");
      print("Longitude : $long");
    });
  }

  @override
  void initState() {
    _getCurrentLocation().then((value) {
      setState(() {
        lat = value.latitude.toString();
        long = value.longitude.toString();
      });
      print("Latitude : $lat");
      print("Longitude : $long");
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

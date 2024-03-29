import 'dart:developer';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

typedef BootstrapBuilder = Future<Widget> Function(
  FirebaseAuth firebaseAuth,
  FirebaseFirestore firebaseFirestore,
  SharedPreferences sharedPreferences,
);

Future<void> bootstrap(BootstrapBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp(
  //   await builder(
  //     FirebaseAuth.instance,
  //     FirebaseFirestore.instance,
  //     await SharedPreferences.getInstance(),
  //   ),
  // await Firebase.initializeApp();
  // runApp(
  // await builder(
  //   FirebaseAuth.instance,
  //   FirebaseFirestore.instance,
  //   await SharedPreferences.getInstance(),
  // )
  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          await builder(
            FirebaseAuth.instance,
            FirebaseFirestore.instance,
            await SharedPreferences.getInstance(),
          ),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );

  // await runZonedGuarded(
  //   () async {
  //     await BlocOverrides.runZoned(
  //       () async => runApp(
  //         await builder(
  //           FirebaseAuth.instance,
  //           FirebaseFirestore.instance,
  //           await SharedPreferences.getInstance(),
  //         ),
  //       ),
  //       blocObserver: AppBlocObserver(),
  //     );
  //   },
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:test_auth_firebase/app/modules/app/views/app_view.dart';

import 'app/config/constants/application.dart';
import 'app/data/services/services.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      await initService();
      runApp(
        GestureDetector(
          onTap: WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus,
          child: AppView(),
        ),
      );
    },
    (error, stack) => Get.log('ERROR main 25'),
  );
}

Future<void> initService() async {
  Get.log('Starting services');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Application.setPreferences();
  await Services.register();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.log('All services started');
}

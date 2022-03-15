import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isAndroid) {
      return FirebaseOptions(
        apiKey: "AIzaSyAaIBrdMcUAOrYlzMVt2aQgR5P1CfU5KqQ",
        projectId: "testauth-420a2",
        messagingSenderId: '632092174222',
        appId: "1:632092174222:android:4249024d3ac6b62ef826df",
      );
    } else {
      return FirebaseOptions(
        apiKey: "AIzaSyAaIBrdMcUAOrYlzMVt2aQgR5P1CfU5KqQ",
        projectId: "testauth-420a2",
        messagingSenderId: '632092174222',
        appId: "1:632092174222:ios:4249024d3ac6b62ef826df",
      );
    }
  }
}

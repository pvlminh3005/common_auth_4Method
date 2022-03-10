import 'package:get/get.dart';

import 'auth_service.dart';
import 'user_service.dart';

class Services {
  static Future<void> register() async {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => UserService());
  }
}

import 'package:get/get.dart';

import '../controllers/login_email_controller.dart';
import '../controllers/login_phone_controller.dart';

class LoginMailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginEmailController());
  }
}

class LoginPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPhoneController());
  }
}

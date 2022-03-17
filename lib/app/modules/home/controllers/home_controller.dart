import 'package:get/get.dart';
import 'package:test_auth_firebase/app/data/services/auth_service.dart';
import 'package:test_auth_firebase/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final AuthService authService = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> signOut() async {
    await 1.delay();
    await authService.signOut();
    Get.offAllNamed(Routes.AUTH);
  }

  @override
  void onClose() {}
}

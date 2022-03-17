import 'package:get/get.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/screen/email_method.dart';
import 'package:test_auth_firebase/app/modules/login/views/method_auth.dart';
import 'package:test_auth_firebase/app/modules/login/views/phone/phone_method.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/views/google/google_method.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => MethodAuth(),
      children: [
        GetPage(
          name: _Paths.LOGIN_EMAIL,
          page: () => EmailMethodBuilder(
            onSuccessLogin: () => Get.offAllNamed(Routes.HOME),
            onSuccessRegister: () => Get.offAllNamed(Routes.HOME),
          ),
        ),
        GetPage(
          name: _Paths.LOGIN_PHONE,
          page: () => LoginPhoneBuilder(),
          // binding: LoginPhoneBinding(),
        ),
        GetPage(
          name: _Paths.LOGIN_GOOGLE,
          page: () => LoginGoogleBuilder(),
          // binding: LoginPhoneBinding(),
        ),
      ],
    ),
  ];
}

import 'package:get/get.dart';
import 'package:test_auth_firebase/app/modules/login/views/login_email_view.dart';
import 'package:test_auth_firebase/app/modules/login/views/method_login.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_phone_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

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
      name: _Paths.LOGIN,
      page: () => MethodLogin(),
      children: [
        GetPage(
          name: _Paths.LOGIN_EMAIL,
          page: () => LoginEmailView(),
          binding: LoginMailBinding(),
        ),
        GetPage(
          name: _Paths.LOGIN_PHONE,
          page: () => LoginPhoneView(),
          binding: LoginPhoneBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
  ];
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_auth_firebase/app/data/services/auth_service.dart';
import 'package:test_auth_firebase/app/modules/app/bindings/app_binding.dart';

import '../../../routes/app_pages.dart';
import '../controllers/app_controller.dart';

class AppView extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      getPages: AppPages.routes,
      home: const LoadingView(),
      initialBinding: AppBinding(),
    );
  }
}

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  void initState() {
    2.delay(() {
      Get.offAllNamed(
        Get.find<AuthService>().isSignIn ? Routes.HOME : Routes.LOGIN,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(strokeWidth: 3.0));
  }
}

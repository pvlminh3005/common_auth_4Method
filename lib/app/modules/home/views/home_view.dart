import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_auth_firebase/app/widgets/button_custom.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(controller.authService.user?.email ?? 'Unknown'),
              const SizedBox(height: 20),
              ButtonCustom(
                'Log out',
                onPressed: controller.signOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

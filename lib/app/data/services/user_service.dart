import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/config/constants/db_path.dart';
import 'package:test_auth_firebase/app/data/services/auth_service.dart';
import 'package:test_auth_firebase/app/widgets/common/snack_bar_custom.dart';

import '../models/user_model.dart';

class UserService extends GetxService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _reference =
      _firestore.collection(DbPath.users);

  Future<void> createUserWithEmail(String email) async {
    try {
      final _user = UserModel(
        uid: Get.find<AuthService>().user!.uid,
        email: email,
        phone: '',
      );
      await _reference.doc(_user.uid).set(_user.toMap());
    } on FirebaseException catch (e) {
      SnackBarCustom.showShackBar(errorText: e.message);
      throw Exception(e);
    }
  }
}

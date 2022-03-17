import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/config/constants/application.dart';
import 'package:test_auth_firebase/app/data/services/user_service.dart';
import 'package:test_auth_firebase/app/widgets/common/snack_bar_custom.dart';

import '../models/user_model.dart';

class AuthService extends GetxService {
  final UserService _userService = Get.find();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // StreamSubscription? _subscription;

  final _isSignIn = false.obs;
  bool get isSignIn => _isSignIn.value;

  User? _user;
  User? get user => _user;

  final _currentUser = Rxn<UserModel>();
  UserModel? get currentUser => _currentUser.value;
  set currentUser(UserModel? user) => _currentUser(user);

  @override
  void onInit() {
    _user = _firebaseAuth.currentUser;
    _isSignIn(_firebaseAuth.currentUser != null);
    // }

    // _subscription = _firebaseAuth.authStateChanges().listen((val) {
    //   _user = val;
    //   _isSignIn.value = val != null;
    // });

    super.onInit();
  }

  Future<void> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) async => await _userService.createUserWithEmail(email),
          )
          .catchError((error) {
        throw Exception(error);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        SnackBarCustom.showShackBar(
          errorText: 'The account already exists for that email.',
        );
        throw Exception(e);
      }
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Application.setToken(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarCustom.showShackBar(errorText: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        SnackBarCustom.showShackBar(
            errorText: 'Wrong password provided for that user.');
      }
      throw Exception(e);
    }
  }

  void signInWithPhoneNumber(
    String yourPhone, {
    Function(String)? onSuccess,
    Function(FirebaseAuthException)? onFailed,
    Function(String)? onTimeout,
  }) {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: yourPhone,
      verificationCompleted: (PhoneAuthCredential credential) {
        print(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed?.call(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        onSuccess?.call(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        onTimeout?.call(verificationId);
      },
    );
  }

  Future<void> verifyOTP({
    required String verificationId,
    required String code,
    required Function(UserCredential) onSuccess,
    required Function(dynamic) onError,
  }) async {
    var credentials = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );

    await _firebaseAuth
        .signInWithCredential(credentials)
        .then(onSuccess)
        .catchError(onError);
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.log(e.message!);
    }
  }
}

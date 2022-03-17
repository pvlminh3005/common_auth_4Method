part of firebase_auth;

// class FirebaseAuthService implements FirebaseAuthBase {
//   @override
//   Future<void> loginWithGoogle() async {}

//   @override
//   Future<void> loginWithMail() async {}

//   @override
//   Future<void> loginWithPhone(String phoneNumber) async {
//     try {
//       FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

mixin FirebaseAuthMixin {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception(e.message);
      }
    }
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    Get.log(email);

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> loginWithPhone({
    String phoneNumber = '',
    Function(FirebaseAuthException?)? onFailed,
    Function(String, int?)? onSuccess,
    Function(String)? onTimeout,
  }) async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed?.call(e);
        throw Exception(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        onSuccess?.call(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        onTimeout?.call(verificationId);
        throw Exception(verificationId);
      },
    );
  }

  Future<void> verifyPhoneNumber({
    required String verificationId,
    required String smsCode,
    required Function(UserCredential) onSuccess,
    required Function(dynamic) onError,
  }) async {
    try {
      var credentials = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await _firebaseAuth.signInWithCredential(credentials).then(onSuccess);
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }
}

part of firebase_auth;

class FirebaseAuthService implements FirebaseAuthBase {
  @override
  Future<void> loginWithGoogle() async {}

  @override
  Future<void> loginWithMail() async {}

  @override
  Future<void> loginWithPhone(String phoneNumber) async {
    try {
      FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
    } catch (e) {
      rethrow;
    }
  }
}

mixin FirebaseAuthMixin {
  Future<void> loginWithGoogle() async {}
}

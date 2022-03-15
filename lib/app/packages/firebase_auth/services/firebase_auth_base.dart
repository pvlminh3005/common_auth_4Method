part of firebase_auth;

abstract class FirebaseAuthBase {
  Future<void> loginWithGoogle();
  Future<void> loginWithMail();
  Future<void> loginWithPhone(String phoneNumber);
}

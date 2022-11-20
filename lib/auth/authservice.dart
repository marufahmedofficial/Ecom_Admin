import 'package:firebase_auth/firebase_auth.dart';

import '../db/db_helper.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<bool> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return DbHelper.isAdmin(credential.user!.uid);
  }

  static Future<void>forgotPassword() {
    return _auth.sendPasswordResetEmail(email: 'mk6116055@gmail.com');
  }

  static Future<void> logout() => _auth.signOut();
}
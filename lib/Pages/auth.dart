import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIN(String email, String password) async {
    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user.uid;
  }

// create account

  Future<String> signUP(String email, String password) async {
    AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user.user.uid;
  }

// Signout user

  Future<void> signout() async {
    _firebaseAuth.signOut();
  }

// signin

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }
}

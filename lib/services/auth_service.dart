import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _fireAuth.currentUser;
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      final credential = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("Users").doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'email': email,
      });

      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login failed');
    }
  }

  Future<UserCredential> signUp(String email, password) async {
    try {
      final credential = await _fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection("Users").doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'email': email,
      });

      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Register failed');
    }
  }

  void signOut() async {
    await _fireAuth.signOut();
  }
}

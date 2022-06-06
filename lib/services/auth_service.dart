import 'package:buzzer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String toString() {
    return _auth.currentUser!.uid;
  }

  String getEmail() {
    return _auth.currentUser!.email.toString();
  }

  Future updateUserEmail(String email) async {
    await _auth.currentUser!.updateEmail(email);
  }

  BuzzUser? _userFromFirebase(User? user) {
    return user != null ? BuzzUser(userId: user.uid) : null;
  }

  Stream<BuzzUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // sign in with email & password
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  // sign up with email & password
  Future signupWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  // sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

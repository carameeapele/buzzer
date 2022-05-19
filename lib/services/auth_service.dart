import 'package:buzzer/models/buzz_user.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //get user => _auth.currentUser;

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
      print(e.toString());
      return null;
    }
  }

  // sign up with email & password
  Future signupWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData(
          'New Event',
          DateTime.now(),
          'Location',
          DateTime.now(),
          DateTime.now(),
          0,
          'Notes');

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

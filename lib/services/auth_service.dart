import 'package:buzzer/models/user_model.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String toString() {
    return _auth.currentUser!.uid;
  }
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
      // await DatabaseService(uid: user!.uid).updateEvent(
      //     'New Event',
      //     DateTime.now(),
      //     'Location',
      //     DateTime.now(),
      //     DateTime.now(),
      //     0,
      //     'Notes');

      // await DatabaseService(uid: user.uid)
      //     .updateTask('New Task', DateTime.now(), 'None', 'Details');

      await DatabaseService(uid: user!.uid).addUserInfo(
        'New User',
        'College',
      );

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

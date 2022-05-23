import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/wrapper.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _auth = AuthService();

  bool loading = false;
  String error = '';

  dynamic userName;
  Future<dynamic> getUserName() async {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection('user_info')
        .doc(_auth.toString());

    await docRef.get().then<dynamic>((DocumentSnapshot snapshot) async {
      if (snapshot.data() != null) {
        setState(() {
          userName = snapshot.data();
        });
      } else {
        setState(() {
          error = 'Could not connect to databse';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBarWidget(
              title: 'Settings',
            ),
            drawer: MenuDrawer(
              name: userName['name'],
              email: _auth.getEmail(),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await _auth.signout();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Wrapper(),
                      ));
                    },
                    child: const Text('Sign out'),
                  ),
                ],
              ),
            ),
          );
  }
}

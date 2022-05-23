import 'package:buzzer/main.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/wrapper.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/style/text_form_field_style.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:buzzer/widgets/text_button_widget.dart';
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
  String name = '';
  String email = '';

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Name'),
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  TextButtonWidget(
                    text: 'Update Data',
                    function: () async {
                      if (name.isNotEmpty) {
                        setState(() {
                          loading = true;
                        });

                        dynamic result =
                            await DatabaseService(uid: _auth.toString())
                                .updateUserInfo(name);

                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Unexpected Error Occured';
                          });
                        }
                      }

                      if (email.isNotEmpty) {
                        setState(() {
                          loading = true;
                        });

                        dynamic result = await _auth.updateUserEmail(email);

                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Unexpected Error Occured';
                          });
                        }
                      }

                      if (loading) {
                        initState();
                      }
                    },
                    backgroundColor: BuzzerColors.lightGrey,
                    textColor: Colors.black,
                  ),
                  TextButtonWidget(
                      text: 'Sign out',
                      function: () async {
                        setState(() {
                          loading = true;
                        });
                        await _auth.signout();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Wrapper(),
                        ));
                      },
                      backgroundColor: BuzzerColors.lightGrey,
                      textColor: Colors.black),
                ],
              ),
            ),
          );
  }

  bool validateFields() {
    if (name.isNotEmpty && email.isEmpty) {
      return true;
    } else {
      SnackBar snack = const SnackBar(
        content: Text('Please fill in Name'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }

    return false;
  }
}

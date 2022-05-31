import 'package:buzzer/main.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/wrapper.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/style/text_form_field_style.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/text_button_widget.dart';
import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final AuthService _auth = AuthService();

  bool loading = false;
  String error = '';
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              titleSpacing: 0.0,
              title: Text(
                'Account Settings',
                style: appBarTextStyle,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                        widget.createState();
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
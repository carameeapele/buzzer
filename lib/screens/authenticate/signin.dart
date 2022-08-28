import 'package:buzzer/main.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/filled_text_button_widget.dart';
import 'package:buzzer/widgets/spacer_button.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  TextEditingController controller = TextEditingController();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 25.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Welcome\nBack',
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFieldWidget(
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              textCapitalization: TextCapitalization.none,
                              onChannge: (value) {
                                setState(() {
                                  email = value.toString().trim();
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFieldWidget(
                              labelText: 'Password',
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              textCapitalization: TextCapitalization.none,
                              onChannge: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      FilledTextButtonWidget(
                        onPressed: () async {
                          if (validateFields()) {
                            setState(() {
                              loading = true;
                            });

                            dynamic result = await _auth
                                .signinWithEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Incorrect Email or Password';
                              });
                            } else {
                              Navigator.of(context).popAndPushNamed('/home');
                            }
                          }
                        },
                        text: 'Login',
                        icon: false,
                        backgroundColor: BuzzerColors.orange,
                        textColor: Colors.white,
                      ),
                      SpacerButton(
                        text: 'Don\'t have an account?',
                        buttonText: 'Register',
                        function: () {
                          Navigator.of(context).popAndPushNamed('/signup');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  bool validateFields() {
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      SnackBar snack = const SnackBar(
        content: Text('Email or password not correct'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }

    return false;
  }
}

import 'package:buzzer/main.dart';
import 'package:buzzer/models/user_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/widgets/filled_text_button_widget.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/spacer_button.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool loading = false;

  String name = '';
  String email = '';
  String password = '';
  String emailError = '';
  String passwordError = '';

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
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Welcome To\nBuzzer',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFieldWidget(
                              labelText: 'Name',
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              textCapitalization: TextCapitalization.words,
                              onChannge: (value) {
                                setState(() {
                                  name = value.toString();
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
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
                              height: 15.0,
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
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextFieldWidget(
                              labelText: 'Confirm Password',
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              textCapitalization: TextCapitalization.none,
                              onChannge: (value) {
                                if (password != value) {
                                  setState(() {
                                    passwordError =
                                        'Password must be the same as previous';
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      FilledTextButtonWidget(
                        text: 'Sign up',
                        icon: false,
                        onPressed: () async {
                          if (validateFields()) {
                            setState(() {
                              loading = true;
                            });

                            dynamic result =
                                await _auth.signupWithEmailAndPassword(
                                    email, password, name);

                            if (result == null) {
                              setState(() {
                                loading = false;
                                SnackBar snack = const SnackBar(
                                  content: Text('Could Not Register'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snack);
                              });
                            } else {
                              Navigator.of(context).popAndPushNamed('/home');
                            }
                          }
                        },
                        backgroundColor: BuzzerColors.orange,
                        textColor: Colors.white,
                      ),
                      SpacerButton(
                        text: 'Already have an account?',
                        buttonText: 'Login',
                        function: () {
                          Navigator.of(context).popAndPushNamed('/signin');
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
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        validateEmail() &&
        validatePassword()) {
      return true;
    } else {
      SnackBar snack = const SnackBar(
        content: Text('Email or Password Not Correct'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    return false;
  }

  bool validateEmail() {
    if (email.contains('@') &&
        (email.endsWith('.com') || email.endsWith('.ro'))) {
      return true;
    } else {
      setState(() {
        emailError = 'Invalid email address';
      });
      return false;
    }
  }

  bool validatePassword() {
    if (password.length >= 6) {
      return true;
    } else {
      setState(() {
        passwordError = 'Must be at least 6 characters';
      });
      return false;
    }
  }

  // Future addUser(String name, String email, String password) async {
  //   final user = BuzzUser(userId: '');
  // }
}

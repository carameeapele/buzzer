import 'package:buzzer/main.dart';
import 'package:buzzer/screens/authenticate/signup.dart';
import 'package:buzzer/screens/home/home.dart';
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
                            // TextFieldWidget(
                            //   labetText: 'Email',
                            //   obscureText: false,
                            //   onChannge: (value) {
                            //     setState(() {
                            //       email = value.toString().trim();
                            //     });
                            //   },
                            // ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                floatingLabelStyle: TextStyle(
                                  color: BuzzerColors.orange,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                    color: BuzzerColors.grey,
                                    width: 2.0,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: BuzzerColors.grey,
                                  fontFamily: 'Roboto',
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                    color: BuzzerColors.orange,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              validator: (val) =>
                                  val!.isEmpty ? 'Please enter an email' : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val.toString().trim();
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                floatingLabelStyle: TextStyle(
                                  color: BuzzerColors.orange,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                    color: BuzzerColors.grey,
                                    width: 2.0,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: BuzzerColors.grey,
                                  fontFamily: 'Roboto',
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                    color: BuzzerColors.orange,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              validator: (val) => val!.isEmpty
                                  ? 'Please enter the password'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
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
                        function: () async {
                          if (validateFields()) {
                            setState(() {
                              loading = true;
                            });

                            dynamic result = await _auth
                                .signinWithEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Email or password incorrect';
                              });
                            } else {
                              Navigator.of(context).popAndPushNamed('/home');
                            }
                          }
                        },
                        text: 'Login',
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

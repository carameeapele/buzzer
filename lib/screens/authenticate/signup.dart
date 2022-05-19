import 'package:buzzer/screens/authenticate/signin.dart';
import 'package:buzzer/screens/home/home.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/style/text_form_field_style.dart';
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
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Welcome\nTo Buzzer',
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Name'),
                              validator: (val) => val!.isEmpty
                                  ? 'Please enter your name'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: controller,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Email'),
                              validator: (val) =>
                                  val!.isEmpty ? 'Please enter an email' : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Password'),
                              validator: (val) => val!.isEmpty
                                  ? 'Please enter the password'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 60.0,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (validateFields()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signupWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Could not register';
                              });
                            } else {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Home(),
                              ));
                            }
                          }
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Spacer(),
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 13.0,
                            ),
                            //textAlign: TextAlign.end,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ));
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 13.0,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      )
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

import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/wrapper.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBarWidget(
              title: 'Settings',
            ),
            //drawer: const MenuDrawer(),
            body: Column(
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
                      builder: (context) => Wrapper(),
                    ));
                  },
                  child: const Text('Sign out'),
                ),
              ],
            ),
          );
  }
}

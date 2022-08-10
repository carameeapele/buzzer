import 'package:buzzer/main.dart';
import 'package:buzzer/screens/settings/account_settings.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:buzzer/widgets/filled_text_button_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const AppBarWidget(
        title: 'Settings',
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FilledTextButtonWidget(
                text: 'Account',
                function: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AccountSettings(),
                  ));
                },
                backgroundColor: BuzzerColors.lightGrey,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

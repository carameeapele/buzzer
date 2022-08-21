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
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FilledTextButtonWidget(
                text: 'Account',
                icon: false,
                onPressed: () {
                  Navigator.of(context).pushNamed('/account_settings');
                },
                backgroundColor: BuzzerColors.lightGrey,
                textColor: Colors.black,
              ),
              const SizedBox(
                height: 5.0,
              ),
              FilledTextButtonWidget(
                onPressed: () {
                  Navigator.of(context).pushNamed('/general_settings');
                },
                text: 'General',
                icon: false,
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

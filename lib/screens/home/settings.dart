import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/style/menu_drawer_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(
        title: 'Settings',
      ),
      drawer: const MenuDrawer(),
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: () async {},
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

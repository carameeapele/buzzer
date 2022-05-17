import 'package:buzzer/components/app_bar_widget.dart';
import 'package:buzzer/components/menu_drawer.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        title: 'Settings',
      ),
      drawer: MenuDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/setting_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SettingItem(icon: Icons.notifications, title: "Notifications"),
          SettingItem(icon: Icons.thermostat, title: "Temperature Unit"),
          SettingItem(icon: Icons.language, title: "Language"),
          SettingItem(icon: Icons.info, title: "About"),
        ],
      ),
    );
  }
}
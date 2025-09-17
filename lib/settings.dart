import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindfulapp/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        //List view makes the screen scollable
        padding: const EdgeInsets.all(16.0),
        children: [
          // shows a privacy message
          const Text(
            'All your data while using this app is completely private, no one but you has access to it',
            style: TextStyle(fontSize: 16.0),
          ),
          // widgets for the switches and buttons
          const SizedBox(height: 20.0),
          _buildDarkModeSwitch(context, themeProvider),
          const SizedBox(height: 20.0),
          _buildPushNotificationSwitch(),
          const SizedBox(height: 20.0),
          _buildAboutAppButton(context),
        ],
      ),
    );
  }

// creates a switch for toggling dark mode
  Widget _buildDarkModeSwitch(
      BuildContext context, ThemeProvider themeProvider) {
    return ListTile(
      title: const Text('Dark Mode'), // names switch
      trailing: Switch(
        value:
            themeProvider.themeMode == ThemeMode.dark, // current value switch
        onChanged: (value) {
          ThemeMode newMode = value ? ThemeMode.dark : ThemeMode.light;
          themeProvider.setThemeMode(newMode); // sets new theme mode
        },
      ),
    );
  }

  Widget _buildPushNotificationSwitch() {
    bool isNotificationOn = true; // notification status

    return ListTile(
      title: const Text('Push Notifications'),
      trailing: Switch(
        value: isNotificationOn,
        onChanged: (value) {
          // Handle push notification toggle
          // Set state or update notification status
        },
      ),
    );
  }

  Widget _buildAboutAppButton(BuildContext context) {
    return ListTile(
      title: const Text('About This App'),
      onTap: () {
        Navigator.pushNamed(context, '/about_app');
      },
    );
  }
}

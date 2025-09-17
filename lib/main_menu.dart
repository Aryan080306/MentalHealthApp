import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate the user to the settings screen
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildMenuItem(context, 'Daily tasks', '/daily_tasks'),
          _buildMenuItem(context, 'Weekly tasks', '/weekly_tasks'),
          _buildMenuItem(context, 'Record Mood again', '/daily_happiness'),
          _buildMenuItem(context, 'Mood chart', '/mood_chart'),
          _buildMenuItem(context, 'Past Moods', '/past_moods'),
          _buildMenuItem(context, 'Notifications', '/notifications'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

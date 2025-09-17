import 'package:flutter/material.dart';
import 'package:mindfulapp/about_app.dart';
import 'package:mindfulapp/daily_task.dart';
import 'package:mindfulapp/main_menu.dart';
import 'package:mindfulapp/mood_chart.dart';
import 'package:mindfulapp/notifications.dart';
import 'package:mindfulapp/past_moods.dart';
import 'package:mindfulapp/record_mood.dart';
import 'package:mindfulapp/venting.dart';
import 'package:mindfulapp/weekly_task.dart';
import 'package:mindfulapp/settings.dart';
import 'package:mindfulapp/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      // sets the dark and light theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      // sets initial screen as menu screen
      home: const MainMenuScreen(),
      // routes of screens
      routes: {
        '/daily_tasks': (context) => const TaskListScreen(),
        '/weekly_tasks': (context) => const WeeklyTaskScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about_app': (context) => const AboutAppScreen(),
        '/daily_happiness': (context) => RecordMoodScreen(),
        '/past_moods': (context) => const PastMoodsScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/mood_chart': (context) => MoodChartScreen(),
        '/venting': (context) {
          final MoodEntry moodEntry =
              ModalRoute.of(context)!.settings.arguments as MoodEntry;
          return VentingScreen(moodEntry: moodEntry);
        },
        // Other routes for different screens
      },
    );
  }
}

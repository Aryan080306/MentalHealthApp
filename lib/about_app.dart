import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About the App'),
      ),
      // creates more of the UI of the screen,
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Adds a subheading
              Text(
                'About the App',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // creates a paragraph of what the app does
              SizedBox(height: 16.0),
              Text(
                'What is this app about?\n'
                'Hush is an app that attempts to improve your mood. It does this by providing multiple features. These features are as follows:\n\n'
                '• Daily happiness scale → A scale of 5 different emoticons where you can decide and pick which one represents how you are currently feeling.\n\n'
                '• Venting area → An area (with prompt questions) where you have a chance to write out your feelings or about how your day went. You can also look back on these!\n\n'
                '• Daily task list → Here you can write anything that you would like to implement within your daily routine or that you would like completed by the end of the day.\n\n'
                '• Weekly task list → Here you can write anything that you would like completed by the end of the week.\n\n'
                '• Mood chart → A chart where you can watch your emotions vary overtime, however if you would not like to see this, then you have the option to turn it off.\n\n'
                '• Positive Customizable Notifications → You can customize the positive notifications that will be sent to your phones throughout the day.\n\n'
                'This app is trying to bring a positive aspect to your phone and help support your mental well-being. It does this by aiding you in being organized and providing positive encouragement.',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

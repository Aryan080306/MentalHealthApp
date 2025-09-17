import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Importing fl_chart package
import 'storage.dart'; // Importing storage file to access mood data
import 'record_mood.dart';

class MoodChartScreen extends StatelessWidget {
  MoodChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // builds method so can build the UI of the widget
    return Scaffold(
      // Scaffold provides a basic material design layout structure
      appBar: AppBar(
        // AppBar represents the app bar at the top of the screen
        title: Text('Mood Chart'),
      ),
      body: FutureBuilder<List<MoodEntry>>(
        future: Storage.readData(), // Reading mood data from storage
        // builder function
        builder: (context, snapshot) {
          // Check the connection state of the snapshot
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the future is still loading, show a loading indicator
            return Center(child: CircularProgressIndicator());
            // If there's an error in the snapshot, display an error message
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Process mood data for chart
            List<MoodEntry>? moodEntries = snapshot.data;
            Map<String, int> moodCounts = _countMoodEntries(moodEntries);
            List<PieChartSectionData> pieChartSections =
                _createPieChartSections(moodCounts);

            return Padding(
              // Padding widget adds padding around its child
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Here is your mood chart! This will show you the amount of each mood that you log over time. Here you can keep track of your emotions and allow yourself to come to terms with how you feel majority of the time. Mood Colours: Happy = Green, Sad = Blue, Confused = Orange, Meh = Grey, Angry = Red',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: pieChartSections,
                        centerSpaceRadius: 60,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Function to count mood entries
  Map<String, int> _countMoodEntries(List<MoodEntry>? moodEntries) {
    Map<String, int> moodCounts = {
      'Happy': 0,
      'Sad': 0,
      'Confused': 0,
      'Meh': 0,
      'Angry': 0,
    };
    // Increments the day tally
    if (moodEntries != null) {
      for (var moodEntry in moodEntries) {
        moodCounts[moodEntry.mood] = (moodCounts[moodEntry.mood] ?? 0) + 1;
      }
    }
    return moodCounts;
  }

  // Function to create pie chart sections from mood counts
  List<PieChartSectionData> _createPieChartSections(
      Map<String, int> moodCounts) {
    List<PieChartSectionData> pieChartSections = [];
    // creates a pie chart section for each mood in the mood counts
    moodCounts.forEach((mood, count) {
      pieChartSections.add(
        PieChartSectionData(
          //setting the section's color, size, and label based on the mood count data.
          color: _getMoodColor(mood),
          value: count.toDouble(),
          title: count.toString(),
          radius: 100,
          titleStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    });

    return pieChartSections;
  }

  // Function to get color for each mood
  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return Colors.green;
      case 'Sad':
        return Colors.blue;
      case 'Confused':
        return Colors.orange;
      case 'Meh':
        return Colors.grey;
      case 'Angry':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

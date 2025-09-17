import 'package:flutter/material.dart';
import 'storage.dart';

class MoodEntry {
  final DateTime date;
  final String mood;
  String vent; // Remove final keyword

  MoodEntry({required this.date, required this.mood, required this.vent});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodEntry &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          mood == other.mood &&
          vent == other.vent;

  @override
  int get hashCode => date.hashCode ^ mood.hashCode ^ vent.hashCode;
}

class RecordMoodScreen extends StatelessWidget {
  RecordMoodScreen({Key? key}) : super(key: key);

  Future<void> _addMoodEntry(BuildContext context, String mood) async {
    MoodEntry newMoodEntry = MoodEntry(
      date: DateTime.now(),
      mood: mood,
      vent: '',
    );

    await Storage.writeData([newMoodEntry]);

    Navigator.pushNamed(context, '/venting', arguments: newMoodEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Mood')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'How was your day?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                _buildMoodButton(context, 'Happy', 'assets/happy.png'),
                _buildMoodButton(context, 'Confused', 'assets/confused.png'),
                _buildMoodButton(context, 'Meh', 'assets/meh.png'),
                _buildMoodButton(context, 'Sad', 'assets/sad.png'),
                _buildMoodButton(context, 'Angry', 'assets/angry.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodButton(BuildContext context, String mood, String imagePath) {
    return GestureDetector(
      onTap: () {
        _addMoodEntry(context, mood);
      },
      child: Column(
        children: [
          Image.asset(imagePath, height: 100, width: 100),
          const SizedBox(height: 8),
          Text(mood),
        ],
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'storage.dart';

// // creates class for mood entry and
// class MoodEntry {
//   final DateTime date;
//   final String mood;
//   String vent;

//   MoodEntry({required this.date, required this.mood, required this.vent});
// }



// //creates a class for the record mood screen
// class RecordMoodScreen extends StatelessWidget {
//   RecordMoodScreen({Key? key}) : super(key: key);

//   Future<void> _addMoodEntry(BuildContext context, String mood) async {
//     // Adds a new mood entry and navigates to the VentingScreen
//     MoodEntry newMoodEntry = MoodEntry(
//       date: DateTime.now(),
//       mood: mood,
//       vent: '', // Initialize venting text as empty
//     );

//     // Read existing mood entries
//     List<MoodEntry> existingEntries = await Storage.readData();

//     // Add the new mood entry to the existing list
//     existingEntries.add(newMoodEntry);

//     // Save all mood entries (including the new one) to storage
//     await Storage.writeData(existingEntries);

//     Navigator.pushNamed(context, '/venting', arguments: newMoodEntry);
//   }

// // creates structure of the screen
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // creates heading
//       appBar: AppBar(title: const Text('Record Mood')),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               // subheading
//               'How was your day?',
//               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(height: 20.0),
//           Expanded(
//             child: ListView(
//               // creates button for each of the moods
//               scrollDirection: Axis.vertical,
//               children: [
//                 _buildMoodButton(context, 'Happy', 'assets/happy.png'),
//                 _buildMoodButton(context, 'Confused', 'assets/confused.png'),
//                 _buildMoodButton(context, 'Meh', 'assets/meh.png'),
//                 _buildMoodButton(context, 'Sad', 'assets/sad.png'),
//                 _buildMoodButton(context, 'Angry', 'assets/angry.png'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// // creates a button to add a mood entry
//   Widget _buildMoodButton(BuildContext context, String mood, String imagePath) {
//     return GestureDetector(
//       onTap: () {
//         _addMoodEntry(context, mood);
//       },
//       child: Column(
//         children: [
//           Image.asset(imagePath, height: 100, width: 100),
//           const SizedBox(height: 8),
//           Text(mood),
//         ],
//       ),
//     );
//   }
// }

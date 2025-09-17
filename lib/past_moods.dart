import 'package:flutter/material.dart';
import 'record_mood.dart';
import 'storage.dart';

class PastMoodsScreen extends StatefulWidget {
  const PastMoodsScreen({Key? key}) : super(key: key);

  @override
  _PastMoodsScreenState createState() => _PastMoodsScreenState();
}

class _PastMoodsScreenState extends State<PastMoodsScreen> {
  late Future<List<MoodEntry>> _futureMoodEntries;

  @override
  void initState() {
    super.initState();
    _futureMoodEntries = Storage.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Moods'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearFile,
          ),
        ],
      ),
      body: FutureBuilder<List<MoodEntry>>(
        future: _futureMoodEntries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<MoodEntry> moodEntries = snapshot.data ?? [];
            return ListView.builder(
              itemCount: moodEntries.length,
              itemBuilder: (context, index) {
                MoodEntry moodEntry = moodEntries[index];
                return _buildMoodEntryItem(moodEntry, () {
                  _deleteMoodEntry(moodEntry);
                });
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildMoodEntryItem(MoodEntry moodEntry, VoidCallback onDelete) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text('Date: ${moodEntry.date.toString()}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mood: ${moodEntry.mood}'),
            Text('Vent: ${moodEntry.vent}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }

  Future<void> _deleteMoodEntry(MoodEntry moodEntry) async {
    try {
      List<MoodEntry> moodEntries = await _futureMoodEntries;
      moodEntries.remove(moodEntry);
      await Storage.writeData(moodEntries);
      setState(() {
        _futureMoodEntries = Future.value(moodEntries);
      });
    } catch (e) {
      print('Error deleting mood entry: $e');
    }
  }
}




// class PastMoodsScreen extends StatefulWidget {
//   const PastMoodsScreen({Key? key}) : super(key: key);

//   @override
//   _PastMoodsScreenState createState() => _PastMoodsScreenState();
// }

// class _PastMoodsScreenState extends State<PastMoodsScreen> {
//   late Future<List<MoodEntry>> _futureMoodEntries;

//   @override
//   void initState() {
//     super.initState();
//     _futureMoodEntries = Storage.readData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Past Moods'),
//       ),
//       body: FutureBuilder<List<MoodEntry>>(
//         future: _futureMoodEntries,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             List<MoodEntry> moodEntries = snapshot.data ?? [];
//             return ListView.builder(
//               itemCount: moodEntries.length,
//               itemBuilder: (context, index) {
//                 MoodEntry moodEntry = moodEntries[index];
//                 return _buildMoodEntryItem(moodEntry, () {
//                   _deleteMoodEntry(moodEntry);
//                 });
//               },
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildMoodEntryItem(MoodEntry moodEntry, VoidCallback onDelete) {
//     return Card(
//       margin: const EdgeInsets.all(16.0),
//       child: ListTile(
//         title: Text('Date: ${moodEntry.date.toString()}'),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Mood: ${moodEntry.mood}'),
//             Text('Vent: ${moodEntry.vent}'),
//           ],
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete),
//           onPressed: onDelete,
//         ),
//       ),
//     );
//   }

//   Future<void> _deleteMoodEntry(MoodEntry moodEntry) async {
//     try {
//       List<MoodEntry> moodEntries = await _futureMoodEntries;
//       moodEntries.remove(moodEntry);
//       await Storage.writeData(moodEntries);
//       setState(() {
//         _futureMoodEntries = Future.value(moodEntries);
//       });
//     } catch (e) {
//       print('Error deleting mood entry: $e');
//     }
//   }
// }















// import 'package:flutter/material.dart';
// import 'record_mood.dart';
// import 'storage.dart';

// // Creates a class for the past moods screen
// class PastMoodsScreen extends StatefulWidget {
//   const PastMoodsScreen({Key? key}) : super(key: key);
// // convereted past moods to a stateful widget
//   @override
//   _PastMoodsScreenState createState() => _PastMoodsScreenState();
// }

// class _PastMoodsScreenState extends State<PastMoodsScreen> {
//   late Future<List<MoodEntry>> _futureMoodEntries;

//   @override
//   void initState() {
//     super.initState();
//     _futureMoodEntries = Storage.readData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Past Moods'),
//       ),
//       body: FutureBuilder<List<MoodEntry>>(
//         future: _futureMoodEntries,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             List<MoodEntry> moodEntries = snapshot.data ?? [];
//             return ListView.builder(
//               itemCount: moodEntries.length,
//               itemBuilder: (context, index) {
//                 MoodEntry moodEntry = moodEntries[index];
//                 return _buildMoodEntryItem(moodEntry, () {
//                   _deleteMoodEntry(moodEntry);
//                 });
//               },
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildMoodEntryItem(MoodEntry moodEntry, VoidCallback onDelete) {
//     return Card(
//       margin: const EdgeInsets.all(16.0),
//       child: ListTile(
//         title: Text('Date: ${moodEntry.date.toString()}'),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Mood: ${moodEntry.mood}'),
//             Text('Vent: ${moodEntry.vent}'),
//           ],
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete),
//           onPressed: onDelete,
//         ),
//       ),
//     );
//   }

//   Future<void> _deleteMoodEntry(MoodEntry moodEntry) async {
//     try {
//       // Retrieve existing mood entries
//       List<MoodEntry> moodEntries = await _futureMoodEntries;

//       // Remove the mood entry to delete
//       moodEntries.remove(moodEntry);

//       // Write updated mood entries back to the file
//       await Storage.writeData(moodEntries);

//       // Update the UI
//       setState(() {
//         _futureMoodEntries = Future.value(moodEntries);
//       });
//     } catch (e) {
//       print('Error deleting mood entry: $e');
//     }
//   }
// }





























// class _PastMoodsScreenState extends State<PastMoodsScreen> {
//   // variable to hold future mood entries
//   late Future<List<MoodEntry>> _futureMoodEntries;

//   @override
//   void initState() {
//     super.initState();
//     // set "_futureMoodEntries" with data from the file
//     _futureMoodEntries = Storage.readData();
//   }

// // creates structure of the screen
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // heading
//         title: const Text('Past Moods'),
//       ),
//       body: FutureBuilder<List<MoodEntry>>(
//         future: _futureMoodEntries,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             List<MoodEntry> moodEntries = snapshot.data ?? [];
//             return ListView.builder(
//               itemCount: moodEntries.length,
//               itemBuilder: (context, index) {
//                 MoodEntry moodEntry = moodEntries[index];
//                 return _buildMoodEntryItem(moodEntry, () {
//                   _deleteMoodEntry(moodEntry);
//                 });
//               },
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }

// // Creates the
//   Widget _buildMoodEntryItem(MoodEntry moodEntry, VoidCallback onDelete) {
//     return Card(
//       margin: const EdgeInsets.all(16.0),
//       child: ListTile(
//         title: Text('Date: ${moodEntry.date.toString()}'),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Mood: ${moodEntry.mood}'),
//             Text('Vent: ${moodEntry.vent}'),
//           ],
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete),
//           onPressed: onDelete,
//         ),
//       ),
//     );
//   }

//   Future<void> _deleteMoodEntry(MoodEntry moodEntry) async {
//     try {
//       List<MoodEntry> moodEntries = await _futureMoodEntries;
//       moodEntries.remove(moodEntry);
//       await Storage.writeData(moodEntries);
//       setState(() {
//         _futureMoodEntries = Future.value(moodEntries);
//       });
//     } catch (e) {
//       print('Error deleting mood entry: $e');
//     }
//   }
// }


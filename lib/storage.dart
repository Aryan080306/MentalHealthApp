import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'record_mood.dart';

class Storage {
  static Future<List<MoodEntry>> readData() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File file = File('${appDocDir.path}/moods.json');
      if (!file.existsSync()) {
        return [];
      }
      String content = await file.readAsString();
      List<dynamic> jsonList = json.decode(content);
      return jsonList.map((entry) {
        return MoodEntry(
          date: DateTime.parse(entry['date']),
          mood: entry['mood'],
          vent: entry['vent'],
        );
      }).toList();
    } catch (e) {
      print('Error reading data: $e');
      return [];
    }
  }

  static Future<void> writeData(List<MoodEntry> newData) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File file = File('${appDocDir.path}/moods.json');

      // Read existing data from the file
      List<MoodEntry> existingEntries = await readData();

      // Add new data only if it doesn't exist already
      for (var entry in newData) {
        if (!existingEntries.contains(entry)) {
          existingEntries.add(entry);
        }
      }

      // Write combined data (existing + new) to the file
      await file.writeAsString(json.encode(existingEntries
          .map((entry) => {
                'date': entry.date.toIso8601String(),
                'mood': entry.mood,
                'vent': entry.vent,
              })
          .toList()));
    } catch (e) {
      print('Error writing data: $e');
    }
  }
}

// Deletes (or shortens) file so its empty
Future<void> clearFile() async {
  try {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File file = File('${appDocDir.path}/moods.json');

    // Check if the file exists
    if (await file.exists()) {
      // Delete the file
      await file.delete();
      // tells me if it has been or if there is an error
      print('File cleared successfully.');
    } else {
      print('File does not exist.');
    }
  } catch (e) {
    print('Error clearing file: $e');
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'record_mood.dart';

// class Storage {
//   // Reads stored mood data from the file
//   static Future<List<MoodEntry>> readData() async {
//     try {
//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       // makes file object which represents the file
//       File file = File('${appDocDir.path}/moods.json');
//       // reads whats in the file as a string
//       String content = await file.readAsString();
//       List<dynamic> jsonList = json.decode(content);
//       return jsonList.map((entry) {
//         // creates mood entry using input
//         return MoodEntry(
//           date: DateTime.parse(entry['date']),
//           mood: entry['mood'],
//           vent: entry['vent'],
//         );
//       }).toList();
//       // if theres an error it prints what the error is
//     } catch (e) {
//       print('Error reading data: $e');
//       return [];
//     }
//   }

// // THIS STUFF IS NEW ADDED

// // Writes mood data to a file without overwriting existing data
//   static Future<void> writeData(List<MoodEntry> newData) async {
//     try {
//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       File file = File('${appDocDir.path}/moods.json');

//       // Convert new data to a list of maps
//       List<Map<String, dynamic>> jsonList = newData.map((entry) {
//         return {
//           'date': entry.date.toIso8601String(),
//           'mood': entry.mood,
//           'vent': entry.vent,
//         };
//       }).toList();

//       // Read existing data from the file
//       List<Map<String, dynamic>> existingData = [];
//       if (file.existsSync()) {
//         String content = await file.readAsString();
//         existingData = List<Map<String, dynamic>>.from(json.decode(content));
//       }

//       // Append new data to existing data
//       existingData.addAll(jsonList);

//       // Write combined data (existing + new) to the file
//       await file.writeAsString(json.encode(existingData));
//     } catch (e) {
//       print('Error writing data: $e');
//     }
//   }
// }

// HAS THE DELETE BUTTON WORKING BUT OVERWRITES

// Writes mood data to a file
//   static Future<void> writeData(List<MoodEntry> data) async {
//     try {
//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       // makes file object which represents the file
//       File file = File('${appDocDir.path}/moods.json');

//       List<Map<String, dynamic>> jsonList = data.map((entry) {
//         return {
//           'date': entry.date.toIso8601String(),
//           'mood': entry.mood,
//           'vent': entry.vent,
//         };
//       }).toList();

//       await file.writeAsString(json.encode(jsonList));
//     } catch (e) {
//       print('Error writing data: $e');
//     }
//   }
// }

// DELETE BUTTON DOESNT WORK BUT APPENDS KINDA

// Writes mood data to a file
//   static Future<void> writeData(List<MoodEntry> data) async {
//     try {
//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       // makes file object which represents the file
//       File file = File('${appDocDir.path}/moods.json');

//       // Convert existing data to a list of maps
//       List<Map<String, dynamic>> existingData = [];
//       if (file.existsSync()) {
//         String content = await file.readAsString();
//         existingData = List<Map<String, dynamic>>.from(json.decode(content));
//       }

//       // Convert new data to a list of maps
//       List<Map<String, dynamic>> newData = data.map((entry) {
//         return {
//           'date': entry.date.toIso8601String(),
//           'mood': entry.mood,
//           'vent': entry.vent,
//         };
//       }).toList();

//       // Append new data to existing data
//       List<Map<String, dynamic>> combinedData = [...existingData, ...newData];

//       // Write combined data to the file
//       await file.writeAsString(json.encode(combinedData));
//     } catch (e) {
//       print('Error writing data: $e');
//     }
//   }
// }

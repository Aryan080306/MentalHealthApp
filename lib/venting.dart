import 'package:flutter/material.dart';
import 'record_mood.dart';
import 'storage.dart';

// creates a class for the venting screen
class VentingScreen extends StatefulWidget {
  final MoodEntry moodEntry;

// constructor for the venting screen widget, takes in key and mood entry as the parameters
  VentingScreen({Key? key, required this.moodEntry}) : super(key: key);
// creates state for the venting screen widget
  @override
  _VentingScreenState createState() => _VentingScreenState();
}

// class for the centing screen widget
class _VentingScreenState extends State<VentingScreen> {
  TextEditingController _ventingController = TextEditingController();

// creates UI of the screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // creates heading
      appBar: AppBar(title: const Text('Venting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // adds subheadin
              const Text(
                'Hello, how was your day? How are you feeling? Anything you would like to talk about?',
                style: TextStyle(fontSize: 16.0),
              ),

              const SizedBox(height: 16.0),
              TextField(
                // Here they can enter venting text
                controller: _ventingController,
                maxLines: null, // allow multiple lines
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Write your thoughts here...',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20.0),
              ElevatedButton(
                // button that will submit data and redirect user
                onPressed: () async {
                  _submitVentingData();
                  // Save mood entry to storage
                  await Storage.writeData([widget.moodEntry]);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Submits venting data and saves it to storage
  void _submitVentingData() {
    String ventingText = _ventingController.text;
    MoodEntry moodEntry = widget.moodEntry;

    moodEntry.vent =
        ventingText; // Update venting text of the existing MoodEntry
  }
}

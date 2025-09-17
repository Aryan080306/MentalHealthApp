import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// creates class for notification screen
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

// creates default example notifications
class _NotificationScreenState extends State<NotificationScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<String> notifications = [
    "Have a good day!",
    "Keep going, you're doing so well!",
    "I am so proud of you!",
  ];
  TextEditingController _notificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // creates structure of the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // creates title
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16.0), // used to have vertical space
              // message for the user to see
              const Text(
                'Here you can customize your notifications to help brighten your day!',
                style: TextStyle(fontSize: 16.0),
              ),

              const SizedBox(height: 20.0),
              _buildNotificationList(),
              const SizedBox(height: 20.0),
              _buildAddNotification(),
              const SizedBox(height: 20.0),
              _buildRandomNotificationButton(),
            ],
          ),
        ),
      ),
    );
  }

// creates the notification list
  Widget _buildNotificationList() {
    return Column(
      // structures the 'children' vertically
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // creates a heading
        const Text(
          'Your Notifications:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          // display list of notifcations
          shrinkWrap: true,
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            // function to build each notification item in the ListView
            return _buildNotificationItem(notifications[index]);
          },
        ),
      ],
    );
  }

// creates a tile for the notfication (makes UI of the notfication)
  Widget _buildNotificationItem(String notification) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(notification),
        trailing: IconButton(
          // icon for deleting the notification
          icon: const Icon(Icons.delete),
          onPressed: () {
            _removeNotification(notification);
          },
        ),
      ),
    );
  }

// implementing the user to add the notification
  Widget _buildAddNotification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // showing subheading to where they can add new notifs
        const Text(
          'Add New Notification:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                // where they can write the new notfication
                controller: _notificationController,
                decoration: const InputDecoration(
                  hintText: 'Type your notification here',
                ),
              ),
            ),
            // creates the add button that will call function
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _addNotification();
              },
            ),
          ],
        ),
      ],
    );
  }

// creates a button to pick and show a random notfication
  Widget _buildRandomNotificationButton() {
    return ElevatedButton(
      onPressed: () {
        _showRandomNotification();
      },
      // name of the button
      child: const Text('Show Random Notification'),
    );
  }

// allows ability to add a new notification
  void _addNotification() {
    String newNotification = _notificationController.text.trim();
    if (newNotification.isNotEmpty) {
      setState(() {
        notifications.add(newNotification);
        _notificationController.clear();
      });
    }
  }

// allows ability to remove notifications
  void _removeNotification(String notification) {
    setState(() {
      notifications.remove(notification);
    });
  }

// picks random notfication and will show it
  void _showRandomNotification() async {
    // checks list is not empty
    if (notifications.isNotEmpty) {
      // chooses a random number in the list's length and gets notfication
      int randomIndex = Random().nextInt(notifications.length);
      String randomNotification = notifications[randomIndex];

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'random_notification_channel',
        'Random Notification Channel',
        // 'Channel for random notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      // displays notification
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,
        'Random Notification',
        randomNotification,
        platformChannelSpecifics,
      );
    }
  }
}

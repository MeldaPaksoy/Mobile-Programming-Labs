import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.orange,
        ledColor: Colors.orange,
      ),
    ],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnnouncementApp(),
    );
  }
}

class AnnouncementApp extends StatefulWidget {
  @override
  _AnnouncementAppState createState() => _AnnouncementAppState();
}

class _AnnouncementAppState extends State<AnnouncementApp> {
  final TextEditingController _textController = TextEditingController();
  String _timeUnit = "Seconds";
  int _timeValue = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Water Notification',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your notification text here',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _timeUnit,
                  items: ["Seconds", "Minutes", "Hours"]
                      .map((unit) => DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _timeUnit = value!;
                    });
                  },
                ),
                DropdownButton<int>(
                  value: _timeValue,
                  items: [5, 10, 15, 20]
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value.toString()),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _timeValue = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _scheduleNotification,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Text('Schedule Notification'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _cancelNotification,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text('Cancel Scheduled Notification'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scheduleNotification() async {
    int timeInSeconds = _convertToSeconds(_timeUnit, _timeValue);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Water Reminder',
        body: _textController.text.isEmpty
            ? 'It\'s time to drink water!'
            : _textController.text,
      ),
      schedule: NotificationCalendar(
        year: DateTime.now().year,
        month: DateTime.now().month,
        day: DateTime.now().day,
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
        second: DateTime.now().second + timeInSeconds,
        millisecond: 0,
        repeats: false,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notification scheduled in $_timeValue $_timeUnit')),
    );
  }

  void _cancelNotification() {
    AwesomeNotifications().cancel(1);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notification cancelled')),
    );
  }

  int _convertToSeconds(String unit, int value) {
    switch (unit) {
      case "Minutes":
        return value * 60;
      case "Hours":
        return value * 3600;
      default:
        return value;
    }
  }
}

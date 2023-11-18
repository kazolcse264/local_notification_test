# Flutter Local Notifications
A New Local Notification Project.
## Step 1: Add Dependencies
Add the following dependencies to your `pubspec.yaml` file:
```yaml
dependencies:
 awesome_notifications:
```
Run
```bash
flutter pub get
``` 
to install the dependencies.

## Step 2: Create a service class and initialize it inside main() method

```dart
class NotificationService {
  static void init() {
    AwesomeNotifications().initialize(
      'resource://drawable/res_notification_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: 'Notification Basic channel for basic tests',
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          defaultColor: Colors.teal,
          locked: true,
          importance: NotificationImportance.High,
          soundSource: 'resource://raw/res_custom_notification',
          channelDescription: 'Notification Schedule channel for basic tests',
        ),
      ],
    );
  }
}
```
In the `main.dart` file, call the `init()` method.
```dart
void main() {
NotificationService.init();
  runApp(const MyApp());
}
```
## Step 3: Handle Notifications in Home Page
In the `home_page.dart` file, implement the `initState()` method to handle different notification scenarios:
```dart
// Add the necessary imports
import 'package:awesome_notifications/awesome_notifications.dart';

@override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t Allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });

    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Notification Created on ${notification.channelKey}',
        ),
      ));
    });

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
              AwesomeNotifications().setGlobalBadgeCounter(value - 1),
        );
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const PlantStatsPage(),
        ),
            (route) => route.isFirst,
      );
    });
  }
```

Don't forget to call `dispose()`
```dart
 @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }
```
## Step 4: Now create simple notification and schedule notification methods inside `NotificationService` class
```dart
 static Future<void> createSimpleNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title:
            '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
        body: 'Florist at 123 Main St. has 2 in stock',
        bigPicture: 'asset://assets/notification_map.png',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  static Future<void> createScheduleNotification(
      NotificationWeekAndTime notificationSchedule) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'scheduled_channel',
        title: '${Emojis.wheater_droplet} Add some water to your plant!',
        body: 'Water your plant regularly to keep it healthy.',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Mark Done',
        ),
      ],
      schedule: NotificationCalendar(
        weekday: notificationSchedule.dayOfTheWeek,
        hour: notificationSchedule.timeOfDay.hour,
        minute: notificationSchedule.timeOfDay.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
    );
  }

  static Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

```
## Step 5: Call this methods from `home_page.dart` file
```dart
ElevatedButton(
            onPressed: NotificationService.createSimpleNotification,
            child: Text(
                  'Send Simple Notification',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
          ),

           ElevatedButton(
            onPressed:  () async {
                NotificationWeekAndTime? pickedSchedule =
                await pickSchedule(context);

                if (pickedSchedule != null) {
                  NotificationService.createScheduleNotification(pickedSchedule);
                }
              },
            child:  const Text(
                  'Send Schedule Notification',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
          ),
```
## Step 6: Run Your App
Run your Flutter app and test local notifications.

That's it! You've successfully set up local notifications in your Flutter app.

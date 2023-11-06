import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/notification_service/notification_handler.dart';

import 'views/home_page.dart';

void main() {
NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        hintColor: Colors.tealAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal, // Set the background color of the AppBar
        ),
      ),
      title: 'Green Thumbs',
      home: const HomePage(),
    );
  }
}

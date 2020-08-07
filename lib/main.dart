// Import
import 'package:flutter/material.dart';
import './Screens/news.dart';
// Main Funtion
void main() => runApp(App());
// Main App Class
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // App Launcher Title
      title: 'الوكالة الوطنية العراقية للأنباء',
      // Theme Settings
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // NEWS HomePage
      home: HomePage(),
    );
  }
}

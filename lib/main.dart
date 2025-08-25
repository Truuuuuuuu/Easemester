import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          //brightness: Brightness.dark, DARK MODE!
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Easemester'),
          centerTitle: true,
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onDestinationSelected: (int value) {
            print(value);
          },
          selectedIndex: 1,
        ),
      ),
    );
  }
}

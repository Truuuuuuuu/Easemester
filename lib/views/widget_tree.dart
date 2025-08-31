import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/views/pages/home_page.dart';
import 'package:easemester_app/views/pages/profile_page.dart';
import 'package:easemester_app/views/pages/workspace_page.dart';
import 'package:flutter/material.dart';
import 'widgets/navbar_widget.dart';
import 'widgets/app_drawer.dart';
import 'package:flutter_switch/flutter_switch.dart';

List<Widget> pages = [
  HomePage(),
  WorkspacePage(),
  ProfilePage(),
]; //pages

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easemester'),
        //dark/light mode btn
        actions: [
          ValueListenableBuilder(
            valueListenable: isDarkModeNotifier,
            builder: (context, isDarkMode, child) {
              return FlutterSwitch(
                value: isDarkMode,
                activeIcon: Icon(
                  Icons.dark_mode,
                  color: const Color.fromARGB(255, 23, 1, 91),
                ),
                inactiveIcon: Icon(
                  Icons.light_mode,
                  color: Colors.yellow,
                ),
                activeColor: Colors.black87,
                inactiveColor: const Color.fromARGB(255, 162, 193, 246),
                toggleSize: 30.0,
                onToggle: (value) {
                  isDarkModeNotifier.value = value;
                },
              );
            },
          ),
        ],

        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}

import 'package:easemester_app/data/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart'; // for exit

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Top header
          DrawerHeader(
            child: Image.asset(
              'assets/images/easemester_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isDarkModeNotifier,
            builder: (context, isDarkMode, child) {
              return FlutterSwitch(
                value: isDarkMode,
                activeIcon: const Icon(
                  Icons.dark_mode,
                  color: Color.fromARGB(255, 23, 1, 91),
                ),
                inactiveIcon: const Icon(
                  Icons.light_mode,
                  color: Colors.yellow,
                ),
                activeColor: Colors.black87,
                inactiveColor: const Color.fromARGB(
                  255,
                  162,
                  193,
                  246,
                ),
                toggleSize: 30.0,
                onToggle: (value) =>
                    isDarkModeNotifier.value = value,
              );
            },
          ),
          // Menu items
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.headset_mic_rounded),
            title: const Text('Support'),
            onTap: () {
              Navigator.pushNamed(context, '/support');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About us'),
            onTap: () {
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Exit'),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}

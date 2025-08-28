import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for exit

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Top header
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Easemester',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
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
            title: const Text('SIgn out'),
            onTap: () {
              SystemNavigator.pop(); 
            },
          ),
        ],
      ),
    );
  }
}

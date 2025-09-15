import 'package:easemester_app/data/constant.dart';
import 'package:flutter/material.dart';
import 'package:easemester_app/views/widgets/app_drawer.dart'; 

class ProfilePage extends StatelessWidget {
  final String userName;
  final String email;
  final String profileImageAsset;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.email,
    required this.profileImageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:
            100, 
        title: const Text(
          'Profile',
          style: AppFonts.heading2,
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 40,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),

      //appdrawer open right
      endDrawer: const AppDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile image
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                profileImageAsset,
              ),
              backgroundColor: Colors.grey[200],
            ),

            const SizedBox(height: 16),

            // Name
            Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),
            // Email
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 12),

            // Edit button
            ElevatedButton.icon(
              onPressed: () {
                // Add edit profile functionality
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Additional info list
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text("College/University"),
                  subtitle: const Text("The Lewis College"),
                ),
                ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: const Text("Course"),
                  subtitle: const Text(
                    "Bachelor of Science in Information Technology",
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text(
                    "Address",
                  ),
                  subtitle: const Text(
                    "San Juan, Casiguran, Sorsogon",
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}

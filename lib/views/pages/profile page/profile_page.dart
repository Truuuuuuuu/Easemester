import 'package:easemester_app/helpers/dialog_helpers.dart';
import 'package:easemester_app/models/profile_model.dart';
import 'package:easemester_app/services/firestore_service.dart';
import 'package:easemester_app/routes/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easemester_app/views/widgets/app_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirestoreService _firestoreService =
      FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? user;
  bool isLoading = true;

  // Additional info fields
  String college = '';
  String course = '';
  String address = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final doc = await _firestoreService.getUser(
          currentUser.uid,
        );
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null && mounted) {
          setState(() {
            user = UserModel.fromMap(currentUser.uid, data);
            college = data['college'] ?? '';
            course = data['course'] ?? '';
            address = data['address'] ?? '';
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching user data: $e'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  //signout
  Future<void> _signOut() async {
    final confirm = await confirmSignOut(context);
    if (confirm == true) {
      await _auth.signOut();
      if (mounted) {
        NavigationHelper.goToLogin(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 40,
              onPressed: () =>
                  Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  // Profile image
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        user != null &&
                            user!.profileImageUrl.isNotEmpty
                        ? NetworkImage(
                            user!.profileImageUrl,
                          )
                        : const AssetImage(
                                'assets/images/default_profile.png',
                              )
                              as ImageProvider,
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Text(
                    user?.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 4),
                  // Email
                  Text(
                    user?.email ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Edit button
                  ElevatedButton(
                    onPressed: user == null
                        ? null
                        : () async {
                            final updated =
                                await NavigationHelper.goToEditProfile(
                                  context,
                                  user!,
                                );
                            if (updated == true) {
                              _fetchUserData();
                            }
                          },
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 32),
                  // Additional info list
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.school),
                        title: const Text(
                          "College/University",
                        ),
                        subtitle: Text(
                          college.isNotEmpty
                              ? college
                              : "Not set",
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.menu_book,
                        ),
                        title: const Text("Course"),
                        subtitle: Text(
                          course.isNotEmpty
                              ? course
                              : "Not set",
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.location_on,
                        ),
                        title: const Text("Address"),
                        subtitle: Text(
                          address.isNotEmpty
                              ? address
                              : "Not set",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Sign Out button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[500],
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                      onPressed: _signOut,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

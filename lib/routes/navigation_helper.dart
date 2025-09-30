import 'package:easemester_app/controllers/notes_controller.dart';
import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import 'app_routes.dart';

class NavigationHelper {
  // Navigate to Edit Profile
  static Future<T?> goToEditProfile<T>(
    BuildContext context,
    UserModel user,
  ) {
    return Navigator.pushNamed(
      context,
      AppRoutes.editProfile,
      arguments: user,
    );
  }

  // Navigate to Login Page and remove all previous routes
  static void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login, 
      (route) => false, // remove all previous routes
    );
  }
  // Navigate to Add Note Form
  static Future<T?> goToAddNote<T>(
    BuildContext context,
    NotesController controller,
  ) {
    return Navigator.pushNamed(
      context,
      AppRoutes.addNote,
      arguments: controller,
    );
  }
}

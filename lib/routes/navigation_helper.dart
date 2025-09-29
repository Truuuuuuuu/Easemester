import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import 'app_routes.dart';

class NavigationHelper {
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
}

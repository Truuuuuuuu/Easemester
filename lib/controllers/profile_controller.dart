import 'package:easemester_app/helpers/dialog_helpers.dart';
import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../services/firestore_service.dart';

class ProfileController {
  final FirestoreService _firestoreService = FirestoreService();

  /// Save profile changes
  Future<bool> saveProfile({
    required BuildContext context,
    required UserModel user,
    required String name,
    required String college,
    required String course,
    required String address,
    String? newProfileImageUrl,
  }) async {
    final confirmed = await confirmChanges(context);
    if (confirmed != true) return false;

    Map<String, dynamic> updatedData = {
      'name': name.trim(),
      'college': college.trim(),
      'course': course.trim(),
      'address': address.trim(),
    };

    if (newProfileImageUrl != null) {
      updatedData['profileImageUrl'] = newProfileImageUrl;
    }

    await _firestoreService.updateUser(user.uid, updatedData);
    return true;
  }
}

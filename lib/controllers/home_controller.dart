import 'package:flutter/material.dart';
import 'package:easemester_app/models/study_card_model.dart';

class HomeController extends ChangeNotifier {
  final TabController tabController;
  final List<StudyCardModel> studyHubCards = [];
  final List<StudyCardModel> filesCards = [];

  HomeController({required this.tabController});

  void addStudyHubCard(StudyCardModel card) {
    print('add file to study hub');
    studyHubCards.add(card);
    notifyListeners(); // 🔥 notify listeners
  }

  void addFileCard(StudyCardModel card) {
    print('add file to files');
    filesCards.add(card);
    notifyListeners(); // 🔥 notify listeners
  }
}

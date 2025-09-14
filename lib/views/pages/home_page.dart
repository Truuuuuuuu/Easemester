import 'package:easemester_app/data/constant.dart';
import 'package:flutter/material.dart';
import 'package:easemester_app/views/widgets/study_card.dart';
import 'package:easemester_app/views/widgets/achievement_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController?
  _tabController; // nullable to avoid lateinit error
  TabController? get tabController => _tabController;

  List<Map<String, String>> studyHubCards = [];
  List<Map<String, String>> filesCards = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void addStudyHubCard(Map<String, String> card) {
    setState(() => studyHubCards.add(card));
  }

  void addFileCard(Map<String, String> card) {
    setState(() => filesCards.add(card));
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Achievement Section
        Container(
          margin: const EdgeInsets.all(12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: const [
                  AchievementItem(
                    title: "Files Uploaded",
                    count: "0",
                  ),
                  AchievementItem(
                    title: "Quizzes Completed",
                    count: "0",
                  ),
                  AchievementItem(
                    title: "Pending Tasks",
                    count: "0",
                  ),
                ],
              ),
            ),
          ),
        ),

        // TabBar
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(
            context,
          ).colorScheme.onSurface.withOpacity(0.6),
          labelStyle: AppFonts.heading3,
          tabs: const [
            Tab(text: "Study Hub"),
            Tab(text: "Files"),
          ],
        ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Study Hub
              GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: studyHubCards.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                itemBuilder: (context, index) {
                  final card = studyHubCards[index];
                  return StudyCard(
                    imageUrl: card['imageUrl']!,
                    description: card['description']!,
                    onTap: () {},
                  );
                },
              ),

              // Files tab
              GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filesCards.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                itemBuilder: (context, index) {
                  final file = filesCards[index];
                  return StudyCard(
                    imageUrl: file['imageUrl']!,
                    description: file['description']!,
                    onTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

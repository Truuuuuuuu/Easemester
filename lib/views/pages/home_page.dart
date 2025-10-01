import 'package:easemester_app/data/constant.dart';
import 'package:flutter/material.dart';
import 'package:easemester_app/views/widgets/study_card.dart';
import 'package:easemester_app/views/widgets/cards/achievement_card.dart';
import 'package:easemester_app/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;

  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller, // listens to HomeController
      builder: (context, _) {
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
              controller: controller.tabController,
              labelColor: Theme.of(
                context,
              ).colorScheme.primary,
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
                controller: controller.tabController,
                children: [
                  // Study Hub
                  GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        controller.studyHubCards.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final card =
                          controller.studyHubCards[index];
                      return StudyCard(
                        card: card,
                        onTap: () {},
                      );
                    },
                  ),

                  // Files tab
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: ListView.builder(
                      itemCount:
                          controller.filesCards.length,
                      itemBuilder: (context, index) {
                        final file =
                            controller.filesCards[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: StudyCard(
                            card: file,
                            onTap: () {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Tapped file: ${file.description}',
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

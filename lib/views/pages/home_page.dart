import 'package:easemester_app/views/widgets/study_card.dart';
import 'package:flutter/material.dart';
import 'package:easemester_app/views/widgets/achievement_card.dart';
import 'package:easemester_app/data/notifiers.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Map<String, String>> files = [];

  void addCard(Map<String, String> newCard) {
    setState(() {
      files.add(newCard);
    });
  }

  @override
  
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, //studyhub and files
      child: Column(
        children: [
          //achievement section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
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
                      title: "Flashcards Created",
                      count: "0",
                    ),
                  ],
                ),
              ),
            ),
          ),

          //tab bar wrapped
          ValueListenableBuilder<int>(
            valueListenable: tabIndexNotifier,
            builder: (context, currentIndex, _) {
              return TabBar(
                onTap: (index) => tabIndexNotifier.value =
                    index, //   
                labelColor: Theme.of(
                  context,
                ).colorScheme.primary,
                unselectedLabelColor: Theme.of(
                  context,
                ).colorScheme.onSurface.withOpacity(0.6),
                indicatorColor: Theme.of(
                  context,
                ).colorScheme.primary,
                tabs: const [
                  Tab(text: "Study Hub"),
                  Tab(text: "Files"),
                ],
              );
            },
          ),

          //tab content
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: tabIndexNotifier,
              builder: (context, currentIndex, _) {
                if (currentIndex == 0) {
                  //  Study Hub tab content
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: files.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return StudyCard(
                        imageUrl: file['imageUrl']!,
                        description: file['description']!,
                        onTap: () {},
                      );
                    },
                  );
                } else {
                  // Files tab content
                  return const Center(
                    child: Text("No files added"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  
}


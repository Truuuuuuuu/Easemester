import 'package:flutter/material.dart';
import 'package:easemester_app/data/constant.dart';
import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/app_actions.dart';
import 'package:easemester_app/views/pages/home_page.dart';

class CustomFAB extends StatelessWidget {
  final GlobalKey<HomePageState> homePageKey;

  const CustomFAB({super.key, required this.homePageKey});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, _) {
        if (selectedPage == 0) {
          // HomePage FAB
          return _buildFab(() {
            final tabController = homePageKey.currentState?.tabController;

            if (tabController != null) {
              if (tabController.index == 0) {
                print('add in study hub');
                homePageKey.currentState?.addStudyHubCard({
                  'imageUrl': 'assets/images/book1.png',
                  'description': 'New Study Hub Card',
                });
              } else if (tabController.index == 1) {
                print('FAB in Files tab');
              }
            } else {
              print("TabController not ready yet.");
            }
          });
        } else if (selectedPage == 1) {
          return _buildFab(addNotesItem); 
        } else if (selectedPage == 2) {
          return _buildFab(addChecklistItem);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFab(VoidCallback onPressed) {
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        backgroundColor: AppColor.whiteBackground,
        child: const Icon(
          Icons.add,
          size: 42,
          color: Colors.black,
        ),
      ),
    );
  }
}

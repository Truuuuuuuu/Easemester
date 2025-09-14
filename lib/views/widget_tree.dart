import 'package:easemester_app/data/constant.dart';
import 'package:flutter/material.dart';
import 'package:easemester_app/views/pages/home_page.dart';
import 'package:easemester_app/views/pages/workspace_page.dart';
import 'package:easemester_app/views/pages/checklist_page.dart';
import 'package:easemester_app/views/pages/profile_page.dart';
import 'package:easemester_app/views/widgets/custom_appbar.dart';
import 'widgets/navbar_widget.dart';
import 'widgets/app_drawer.dart';
import 'package:easemester_app/app_actions.dart';
import 'package:easemester_app/data/notifiers.dart';

final GlobalKey<HomePageState> homePageKey =
    GlobalKey<HomePageState>();

final List<Widget> pages = [
  HomePage(key: homePageKey),
  WorkspacePage(),
  ChecklistPage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),

      floatingActionButton: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, _) {
          if (selectedPage == 0) {
            // HomePage FAB
            return SizedBox(
              width: 70, // ensures a bigger button
              height: 70,
              child: FloatingActionButton(
                onPressed: () {
                  final tabController = homePageKey
                      .currentState
                      ?.tabController;

                  if (tabController != null) {
                    if (tabController.index == 0) {
                      print('FAB in Study Hub');
                      homePageKey.currentState
                          ?.addStudyHubCard({
                            'imageUrl':
                                'assets/images/book1.png',
                            'description':
                                'New Study Hub Card',
                          });
                    } else if (tabController.index == 1) {
                      print('FAB in Files tab');
                    }
                  } else {
                    print("TabController not ready yet.");
                  }
                },
                shape:
                    const CircleBorder(), // circular shape
                backgroundColor: AppColor.whiteBackground,
                child: const Icon(
                  Icons.add,
                  size: 42, // bigger icon
                  color: Colors.black,
                ),
              ),
            );
          } else if (selectedPage == 1) {
            return SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: addWorkspaceItem,
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  size: 42,
                  color: Colors.black,
                ),
              ),
            );
          } else if (selectedPage == 2) {
            return SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: addChecklistItem,
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  size: 42,
                  color: Colors.black,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}

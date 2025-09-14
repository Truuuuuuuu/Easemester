import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/app_actions.dart';
import 'package:easemester_app/views/pages/checklist_page.dart';
import 'package:easemester_app/views/pages/home_page.dart';
import 'package:easemester_app/views/pages/profile_page.dart';
import 'package:easemester_app/views/pages/workspace_page.dart';
import 'package:easemester_app/views/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'widgets/navbar_widget.dart';
import 'widgets/app_drawer.dart';

final GlobalKey<HomePageState> homePageKey =
    GlobalKey<HomePageState>();

List<Widget> pages = [
  HomePage(key: homePageKey),
  WorkspacePage(),
  ChecklistPage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  void addFile() {
    print("Add file triggered!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      endDrawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          if (selectedPage == 0 ||
              selectedPage == 1 ||
              selectedPage == 2) {
            return SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: () {
                  if (selectedPage == 0) {
                    //checks which tab
                    if (tabIndexNotifier.value == 0) {
                      print('add in study hub');
                      // Study Hub FAB action
                      homePageKey.currentState?.addCard({
                        'imageUrl':
                            'assets/images/book1.png',
                        'description': 'New Study Card',
                      });
                    } else if (tabIndexNotifier.value == 1) {
                      // Files FAB action
                      print("Add file in Files tab!");
                      // upload file func
                    }
                  } else if (selectedPage == 1) {
                    addWorkspaceItem();
                  } else if (selectedPage == 2) {
                    addChecklistItem();
                  }
                },
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

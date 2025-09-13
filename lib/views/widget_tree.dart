import 'package:easemester_app/data/constant.dart';
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

List<Widget> pages = [
  HomePage(),
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
          if (selectedPage == 0 || selectedPage == 1 || selectedPage == 2) {
            return SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: () {
                  if (selectedPage == 0) {
                    addHomeFile(); // Home page action
                  } else if (selectedPage == 1) {
                    addWorkspaceItem(); // Workspace page action
                  } else if (selectedPage == 2) {
                    addChecklistItem(); // Checklist page action
                  }
                },
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  size: 36,
                  color: Colors.black,
                ),
              ),
            );
          }
          return const SizedBox.shrink(); // no FAB on other pages
        },
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}

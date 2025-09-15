import 'package:easemester_app/app_actions.dart';
import 'package:easemester_app/views/widgets/fab_widget.dart';
import 'package:flutter/material.dart';
import 'package:easemester_app/views/pages/home_page.dart';
import 'package:easemester_app/views/pages/notes_page.dart';
import 'package:easemester_app/views/pages/checklist_page.dart';
import 'package:easemester_app/views/pages/profile_page.dart';
import 'package:easemester_app/views/widgets/custom_appbar.dart';
import 'widgets/navbar_widget.dart';
import 'widgets/app_drawer.dart';
import 'package:easemester_app/data/notifiers.dart';

final GlobalKey<HomePageState> homePageKey =
    GlobalKey<HomePageState>();

final List<Widget> pages = [
  HomePage(key: homePageKey),
  NotesPage(key: notesKey),
  ChecklistPage(key: checklistKey),
  ProfilePage(
    userName: 'Jethruel Aguilar',
    email: 'jethruel@gmail.com',
    profileImageAsset: 'assets/images/user.png',
  ),
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

      floatingActionButton: CustomFAB(
        homePageKey: homePageKey,
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}

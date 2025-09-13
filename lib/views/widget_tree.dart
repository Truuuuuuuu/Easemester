import 'package:easemester_app/data/constant.dart';
import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/views/pages/checklist_page.dart';
import 'package:easemester_app/views/pages/home_page.dart';
import 'package:easemester_app/views/pages/profile_page.dart';
import 'package:easemester_app/views/pages/workspace_page.dart';
import 'package:flutter/material.dart';
import 'widgets/navbar_widget.dart';
import 'widgets/app_drawer.dart';
import 'package:flutter_switch/flutter_switch.dart';

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
      appBar: AppBar(
        actions: [
          
        ],
      ),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      floatingActionButton: SizedBox(
        width: 70, // increase the width
        height: 70, // increase the height
        child: FloatingActionButton(
          onPressed: addFile,
          shape:
              const CircleBorder(), 
          backgroundColor: KMainColor.icon, 
          child: const Icon(
            Icons.add,
            size: 36, // bigger icon
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}

import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/views/pages/home_page.dart';
import 'package:easemester_app/views/pages/profile_page.dart';
import 'package:easemester_app/views/pages/workspace_page.dart';
import 'package:flutter/material.dart';
import 'widgets/navbar_widget.dart';
import 'widgets/app_drawer.dart';

List<Widget> pages = [HomePage(), WorkspacePage(), ProfilePage()]; //pages

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easemester'),
        actions: [
          IconButton(
            onPressed: () {
              isDarkModeNotifier.value = !isDarkModeNotifier.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDarkMode, child) {
                return Icon(
                  isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                );
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}

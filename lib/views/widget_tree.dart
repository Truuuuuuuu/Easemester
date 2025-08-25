import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/views/pages/home_page.dart';
import 'package:easemester_app/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'widgets/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Easemester'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(valueListenable: selectedPageNotifier, builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },),
        bottomNavigationBar: NavbarWidget(),
      );
  }
}
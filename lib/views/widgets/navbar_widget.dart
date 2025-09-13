import 'package:easemester_app/data/constant.dart';
import 'package:easemester_app/data/notifiers.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: selectedPage == 0 ? KMainColor.icon : Colors.grey[600],
                    size: 35,
                  ),
                  onPressed: () => selectedPageNotifier.value = 0,
                ),
                // Workspace
                IconButton(
                  icon: Icon(
                    Icons.bubble_chart,
                    color: selectedPage == 1 ? KMainColor.icon : Colors.grey[600],
                    size: 35,
                  ),
                  onPressed: () => selectedPageNotifier.value = 1,
                ),
                const SizedBox(width: 40), 
                // Checklist
                IconButton(
                  icon: Icon(
                    Icons.checklist,
                    color: selectedPage == 2 ? KMainColor.icon : Colors.grey[600],
                    size: 35,
                  ),
                  onPressed: () => selectedPageNotifier.value = 2,
                ),
                // Profile
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: selectedPage == 3 ? KMainColor.icon : Colors.grey[600],
                    size: 35,
                  ),
                  onPressed: () => selectedPageNotifier.value = 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

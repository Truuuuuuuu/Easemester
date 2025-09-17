import 'package:easemester_app/data/notifiers.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        Color iconColor(int index) {
          return selectedPage == index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).iconTheme.color!;
        }

        final bool showFab = selectedPage != 3;

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 16,
                right: 16,
              ),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).cardColor,
                child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: iconColor(0),
                          size: 30,
                        ),
                        onPressed: () =>
                            selectedPageNotifier.value = 0,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.sticky_note_2,
                          color: iconColor(1),
                          size: 30,
                        ),
                        onPressed: () =>
                            selectedPageNotifier.value = 1,
                      ),

                      //only part that animates
                      AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                        width: showFab ? 60 : 0,
                      ),

                      IconButton(
                        icon: Icon(
                          Icons.checklist,
                          color: iconColor(2),
                          size: 30,
                        ),
                        onPressed: () =>
                            selectedPageNotifier.value = 2,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.person,
                          color: iconColor(3),
                          size: 30,
                        ),
                        onPressed: () =>
                            selectedPageNotifier.value = 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

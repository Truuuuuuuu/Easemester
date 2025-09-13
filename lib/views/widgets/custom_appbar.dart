import 'package:flutter/material.dart';
import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/data/constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        if (selectedPage == 3) {
          return const SizedBox.shrink(); // No app bar on Profile page
        }

        return SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hello, Jethruel!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Let’s make today productive',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                const Spacer(),
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      color: KMainColor.icon,
                      iconSize: 40,
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:easemester_app/controllers/notes_controller.dart';
import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/firebase_options.dart';
import 'package:easemester_app/models/profile_model.dart';
import 'package:easemester_app/routes/app_routes.dart';
import 'package:easemester_app/views/auth/login_page.dart';
import 'package:easemester_app/views/auth/register_page.dart';
import 'package:easemester_app/views/auth/startup_wrapper.dart';
import 'package:easemester_app/views/pages/notes%20page/addNoteForm_page.dart';
import 'package:easemester_app/views/pages/profile%20page/edit_profile_page.dart';
import 'package:easemester_app/views/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 👇 Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            // CORE ROUTES
            '/': (context) =>
                const StartupWrapper(), // 👈 show onboarding first time only
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            '/home': (context) => const WidgetTree(),
            // DETAIL ROUTES
            AppRoutes.editProfile: (context) {
              final user =
                  ModalRoute.of(context)!.settings.arguments
                      as UserModel;
              return EditProfilePage(user: user);
            },
            AppRoutes.addNote: (context) {
              final controller =
                  ModalRoute.of(context)!.settings.arguments
                      as NotesController;
              return AddNoteFormPage(
                controller: controller,
              );
            },
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF011023),
              brightness: isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
            ),
          ),
        );
      },
    );
  }
}

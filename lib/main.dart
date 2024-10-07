import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/Login.dart';
import 'package:todo_app/pages/MainPage.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/Shared_Pref.dart';
import 'package:todo_app/utils/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDvw9HBspSJ_2Bv7uNJ7P_hc8bmakKoJ3w',
      appId: '1:944678737612:android:f72609d01f832ad7d15469',
      messagingSenderId: 'sendid',
      projectId: 'todo-e0b90',
      storageBucket: 'todo-e0b90.appspot.com',
    ),
  );
  // await Future.delayed(const Duration(seconds: 10));

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the theme provider instance
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Todo App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.thememode,
      home: FutureBuilder<bool>(
        future: SharedPref.getLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while checking login status
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors if any
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Navigate to the appropriate screen based on login status
            final isLoggedIn = snapshot.data ?? false;
            return isLoggedIn ? const MainPage() : const LoginPage();
          } else {
            // Default case, navigate to login page
            return const LoginPage();
          }
        },
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainPage(),
      },
    );
  }
}

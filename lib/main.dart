import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/Login.dart';
import 'package:todo_app/pages/MainPage.dart';
import 'package:todo_app/providers/theme_provider.dart';
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
  ));

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
    // ignore: unused_local_variable
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      darkTheme: lightTheme,
      themeMode: themeProvider.thememode,
      home: const MainPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => MainPage(),
      },
    );
  }
}

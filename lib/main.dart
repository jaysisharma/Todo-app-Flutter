
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/MainPage.dart';
import 'package:todo_app/pages/SplashScreen.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context)=> ThemeProvider(),
    child:  const MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.thememode,
      home: SplashScreen(),
      routes: {
        '/home': (context) => MainPage(),
      },
    );
  }
}
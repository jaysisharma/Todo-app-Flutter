import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.amber, // This replaces the old accentColor
  ),
  // Add other theme properties as needed
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,
    secondary: Colors.deepOrange, // This replaces the old accentColor
  ),
  // Add other theme properties as needed
);

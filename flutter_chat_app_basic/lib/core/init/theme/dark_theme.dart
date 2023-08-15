import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.amber))),
  appBarTheme: AppBarTheme(
      color: Colors.black, iconTheme: IconThemeData(color: Colors.blue)),
  iconTheme: IconThemeData(color: Colors.white),
  drawerTheme: DrawerThemeData(surfaceTintColor: Colors.amber),
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey[800]!,
    secondary: Colors.grey[600]!,
  ),
);

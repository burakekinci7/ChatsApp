import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/constants/colors.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(color: ColorCustom.thirth),
  textButtonTheme: TextButtonThemeData(),
  iconTheme: IconThemeData(color: Colors.black),
  listTileTheme:
      ListTileThemeData(iconColor: Colors.black, textColor: Colors.black),
  drawerTheme: DrawerThemeData(backgroundColor: ColorCustom.first),
  colorScheme: ColorScheme.light(
    background: ColorCustom.first,
    primary: ColorCustom.thirth,
    secondary: ColorCustom.forth,
  ),
);

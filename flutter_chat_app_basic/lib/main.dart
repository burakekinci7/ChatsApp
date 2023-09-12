import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/constants/app_title.dart';
import 'package:flutter_chat_app_basic/core/init/main_init.dart';
import 'package:flutter_chat_app_basic/core/init/theme/dark_theme.dart';
import 'package:flutter_chat_app_basic/core/init/theme/light_theme.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_gate.dart';
import 'package:provider/provider.dart';

void main() async {
  await InitMain.instance.initMain();
  await InitMain.instance.initNotification();

  runApp(
    MultiProvider(
      providers: InitMain.instance.porivderList(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTitle.appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Authgate(),
    );
  }
}

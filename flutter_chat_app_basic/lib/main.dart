import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/constants/app_title.dart';
import 'package:flutter_chat_app_basic/core/init/main_init.dart';
import 'package:flutter_chat_app_basic/core/init/theme/dark_theme.dart';
import 'package:flutter_chat_app_basic/core/init/theme/light_theme.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_gate.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_services.dart';
import 'package:flutter_chat_app_basic/core/services/chat/chat_service.dart';
import 'package:flutter_chat_app_basic/core/services/post/post_services.dart';
import 'package:provider/provider.dart';

void main() async {
  await InitMain.initMain();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
        ChangeNotifierProvider<ChatServices>(
            create: (context) => ChatServices()),
        ChangeNotifierProvider<PostService>(create: (context) => PostService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTitle.appTitle,
      theme: darkTheme,
      darkTheme: darkTheme,
      home: const Authgate(),
    );
  }
}

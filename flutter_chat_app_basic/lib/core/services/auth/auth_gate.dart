import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/services/account/login_or_register.dart';
import 'package:flutter_chat_app_basic/view/pages/post_pages/post_page.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //user is loged in
            return const PostPage();
          } else {
            //user is NOT loged in
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}

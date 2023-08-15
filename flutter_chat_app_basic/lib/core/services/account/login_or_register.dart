import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/view/pages/auth_pages/login_page.dart';
import 'package:flutter_chat_app_basic/view/pages/auth_pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool _showLoadingPage = true;

  void togglepages() {
    setState(() {
      _showLoadingPage = !_showLoadingPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoadingPage) {
      return LoginPage(ontap: togglepages);
    } else {
      return RegisterPage(ontap: togglepages);
    }
  }
}

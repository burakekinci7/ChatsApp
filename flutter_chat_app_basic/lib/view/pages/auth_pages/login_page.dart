import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/button_custom.dart';
import 'package:flutter_chat_app_basic/core/companent/text_field_custom.dart';
import 'package:flutter_chat_app_basic/core/constants/app_title.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback ontap;
  const LoginPage({super.key, required this.ontap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //textediting controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in user
  void signIn() async {
    //get the auth sevices
    final authServices = Provider.of<AuthService>(context, listen: false);
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await authServices.signInWithEmailAndPassworddd(
            emailController.text, passwordController.text);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('please don\'t be blank')));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authServis = context.read<AuthService>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisAlgments
                children: [
                  //logo
                  Icon(
                    IconCustomConst.chatIcon,
                    size: 80,
                    color: Colors.grey[800],
                  ),
                  SizedBox(height: 50),
                  //welcome back message
                  Text(AppTitle.welcomeback,
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 50),

                  //email textfield
                  TextFieldCustom(
                      controller: emailController,
                      hintText: 'email',
                      obscureText: false),
                  SizedBox(height: 20),

                  //password textfield
                  TextFieldCustom(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true),
                  SizedBox(height: 20),

                  //sign in button
                  ButtonCustom(
                    ontap: () {
                      signIn();
                    },
                    text: 'Sign In',
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: IconCustomConst.googleSignIn,
                    onPressed: () {
                      authServis.signInWithGoogle();
                    },
                    label: Text('Google Sigin'),
                  ),
                  //not a mamber? create new account. register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppTitle.notRemember),
                      TextButton(
                          onPressed: widget.ontap,
                          child: const Text(
                            AppTitle.registerNow,
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

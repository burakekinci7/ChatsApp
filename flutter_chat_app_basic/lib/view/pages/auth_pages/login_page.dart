import 'package:firebase_auth/firebase_auth.dart';
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
            emailController.text, passwordController.text, context);
      } on FirebaseAuthException catch (e) {
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  SizedBox(height: 50),
                  //welcome back message
                  Text(
                    AppTitle.welcomeback,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20),
                  ),
                  SizedBox(height: 50),

                  //email textfield
                  TextFieldCustom(
                    controller: emailController,
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    obscureText: false,
                    isEndTextField: false,
                  ),

                  //password textfield
                  TextFieldCustom(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    textInputType: TextInputType.text,
                    isEndTextField: true,
                  ),

                  //sign in button
                  ButtonCustom(
                    ontap: () {
                      signIn();
                    },
                    text: 'Sign In',
                  ),
                  //Google sign in
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    icon: IconCustomConst.googleSignIn,
                    onPressed: () {
                      authServis.signInWithGoogle();
                    },
                    label: Text(
                      'Google Sigin',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background),
                    ),
                  ),
                  //not a mamber? create new account. register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppTitle.notRemember),
                      TextButton(
                        onPressed: widget.ontap,
                        child: Text(
                          AppTitle.registerNow,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

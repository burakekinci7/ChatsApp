import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/button_custom.dart';
import 'package:flutter_chat_app_basic/core/companent/text_field_custom.dart';
import 'package:flutter_chat_app_basic/core/constants/app_title.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback ontap;

  const RegisterPage({super.key, required this.ontap});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //textediting controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    //matches pasword to confirm password
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password do not match!')));
      return;
    }

    //get userAuth
    final authService = context.read<AuthService>();

    //create new user
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //create the user
      UserCredential? userCredential = await authService.createUserEmailAndPass(
          emailController.text, passwordController.text, context);
      //after creating the user, create a new document in cloud firestore called user
      if (userCredential != null) {
        authService.saveToUserName(
            userCredential.user!.uid, emailController.text);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lütfen boş birakmayiniz')));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Icon(
                    IconCustomConst.chatIcon,
                    size: 80,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  SizedBox(height: 50),

                  //create account message
                  Text(AppTitle.createAccount,
                      style: TextStyle(
                        fontSize: 21,
                        color: Theme.of(context).colorScheme.tertiary,
                      )),
                  SizedBox(height: 50),

                  //email textfield
                  TextFieldCustom(
                      controller: emailController,
                      hintText: 'email',
                      obscureText: false,
                      isEndTextField: false,
                      textInputType: TextInputType.emailAddress),

                  //password textfield
                  TextFieldCustom(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    isEndTextField: false,
                    textInputType: TextInputType.multiline,
                  ),

                  //password confirm textfield
                  TextFieldCustom(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    isEndTextField: true,
                    textInputType: TextInputType.text,
                  ),

                  //sign up button
                  ButtonCustom(ontap: signUp, text: 'Sign Up'),

                  //not a mamber? create new account. register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already a member?'),
                      TextButton(
                        onPressed: widget.ontap,
                        child: Text(
                          'Login Now',
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

//simple
final class AppIcona extends Icon {
  const AppIcona({super.key})
      : super(
          Icons.abc,
        );
}

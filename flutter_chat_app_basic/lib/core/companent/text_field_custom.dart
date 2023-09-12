import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final bool isEndTextField;
  const TextFieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.textInputType,
    required this.isEndTextField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: TextField(
        keyboardType: textInputType,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        controller: controller,
        textInputAction:
            isEndTextField ? TextInputAction.done : TextInputAction.next,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.background)),
          fillColor: Theme.of(context).colorScheme.primary,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

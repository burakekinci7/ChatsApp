import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';

class CommentButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CommentButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: IconCustomConst.comment, onPressed: onPressed);
  }
}

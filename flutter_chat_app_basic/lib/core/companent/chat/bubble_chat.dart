import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: isSender ? Colors.purple : Colors.grey,
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }
}

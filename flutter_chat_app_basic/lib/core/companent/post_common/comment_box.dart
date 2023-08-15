import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const CommentBox(
      {super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Commets',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(user),
            const Text('*'),
            Text(time),
          ]),
          Text(text),
        ]),
      ),
    );
  }
}

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
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              user,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text('  *  '),
            Text(time),
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 3),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}

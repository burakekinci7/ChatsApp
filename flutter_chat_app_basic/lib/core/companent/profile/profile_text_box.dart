import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';

class ProfileTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final VoidCallback onPressed;
  const ProfileTextBox(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.only(left: 10, bottom: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //section name
                Text(
                  sectionName,
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),

                //edit button
                IconButton(onPressed: onPressed, icon: IconCustomConst.settings)
              ],
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}

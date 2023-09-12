import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  final String text;
  final Icon icon;
  final VoidCallback onTap;
  const ListTileCustom(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        leading: icon,
        title: Text(
          text,
        ),
      ),
    );
  }
}

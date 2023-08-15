import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  const ButtonCustom({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      
      child: Container(
        padding: EdgeInsets.all(22),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

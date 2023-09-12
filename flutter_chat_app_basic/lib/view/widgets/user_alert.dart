import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WidgetUtils {
  static WidgetUtils intsace = WidgetUtils();

  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  //firestore
  final _firestore = FirebaseFirestore.instance;

  //edit File
  Future<void> editField(String field, BuildContext context) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: TextStyle(color: Colors.grey)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //Cansel button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cansel',
                style: TextStyle(color: Colors.amber),
              )),
          //Save button
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.amber),
              )),
        ],
      ),
    );
    if (newValue.trim().length > 0) {
      //fireabse update new value
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .update({field: newValue});
    }
  }
}

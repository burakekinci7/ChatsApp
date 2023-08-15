import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/loading_screen.dart';
import 'package:flutter_chat_app_basic/core/companent/profile/profile_text_box.dart';

class ProfileHomePage extends StatefulWidget {
  const ProfileHomePage({Key? key}) : super(key: key);
  @override
  State<ProfileHomePage> createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _firestore = FirebaseFirestore.instance;

  //edit File
  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${field}'),
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
          //cansel button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cansel',
                style: TextStyle(color: Colors.amber),
              )),
          //Svae button
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: Text(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(children: [
                //profile pic
                Icon(
                  Icons.people,
                  size: 100,
                ),

                //user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                ),

                //user details const header
                Text(
                  'User Details',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                //username
                ProfileTextBox(
                  text: userData['userName'],
                  sectionName: 'User Name',
                  onPressed: () => editField('userName'),
                ),

                //bio
                ProfileTextBox(
                  text: userData['bio'],
                  sectionName: 'Bio',
                  onPressed: () => editField('bio'),
                ),
              ]),
            );
          } else if (snapshot.hasError) {
            return Text('Eroor ${snapshot.error}');
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}

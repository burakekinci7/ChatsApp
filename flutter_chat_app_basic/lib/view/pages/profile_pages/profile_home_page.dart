import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/loading_screen.dart';
import 'package:flutter_chat_app_basic/core/companent/profile/profile_text_box.dart';
import 'package:flutter_chat_app_basic/view/widgets/user_alert.dart';

class ProfileHomePage extends StatefulWidget {
  const ProfileHomePage({Key? key}) : super(key: key);
  @override
  State<ProfileHomePage> createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data?.data() as Map<String, dynamic>;
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
                  text: userData['userName'] ?? 'Not user name',
                  sectionName: 'User Name',
                  onPressed: () =>
                      WidgetUtils.intsace.editField('userName', context),
                ),

                //bio
                ProfileTextBox(
                  text: userData['bio'] ?? 'not user name',
                  sectionName: 'Bio',
                  onPressed: () =>
                      WidgetUtils.intsace.editField('bio', context),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/view/pages/chat_page.dart';

class UserListHoemPage {
  static Widget buildUserList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('erooor');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListView(doc, context))
                .toList());
      },
    );
  }

  static Widget _buildUserListView(
      DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //get auth instance
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    //display all users exept current user
    if (firebaseAuth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          //pass the clicked user's UID to the chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                ),
              ));
        },
      );
    } else {
      //empty user
      return Container();
    }
  }
}

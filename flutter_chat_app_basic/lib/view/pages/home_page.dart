import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/constants/app_title.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_services.dart';
import 'package:flutter_chat_app_basic/view/widgets/user_list_home_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //sign out user fun
  void signOut() {
    //get authservice
    final authServices = context.read<AuthService>();
    //signOut
    authServices.signOut();
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            firebaseAuth.currentUser!.email.toString() + AppTitle.appTitle),
        actions: [
          IconButton(onPressed: signOut, icon: IconCustomConst.signOutIcon)
        ],
      ),
      body: UserListHoemPage.buildUserList(context),
    );
  }

  /* Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('erooor');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loadingg...");
        }

        return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListView(doc))
                .toList());
      },
    );
  }

  //build individdual user list items
  Widget _buildUserListView(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users exept current user
    if (_firebaseAuth.currentUser!.email != data['email']) {
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
  } */
}

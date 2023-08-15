import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/base/helper/helper_methods.dart';
import 'package:flutter_chat_app_basic/core/companent/drawer/drawer.dart';
import 'package:flutter_chat_app_basic/core/companent/loading_screen.dart';
import 'package:flutter_chat_app_basic/core/companent/post_common/post_custom.dart';
import 'package:flutter_chat_app_basic/core/companent/text_field_custom.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_services.dart';
import 'package:flutter_chat_app_basic/core/services/post/post_services.dart';
import 'package:flutter_chat_app_basic/view/pages/home_page.dart';
import 'package:flutter_chat_app_basic/view/pages/profile_pages/profile_home_page.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //controller
  final TextEditingController postTextController = TextEditingController();

  //send post
  void postMessage() {
    //only post if there is something in the textfield
    if (postTextController.text.isNotEmpty) {
      //store in firebase
      final service = context.read<PostService>();
      service.addPost(
        currentUser.email!,
        postTextController.text,
        Timestamp.now(),
      );
      //clear the textField because add new post :)
      postTextController.clear();
    }
  }

  void goToProfilePage() {
    //pop the drawer menu
    Navigator.pop(context);

    //push profile page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileHomePage(),
        ));
  }

  void goToChatPage() {
    //pop the drawer menu
    Navigator.pop(context);

    //push profile page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
  }

  void signOut() {
    //get authservice
    final authServices = context.read<AuthService>();
    //signOut
    authServices.signOut();
  }

  @override
  void dispose() {
    super.dispose();
    postTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: DrawerCustom(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
        chatTap: goToChatPage,
      ),
      appBar: AppBar(
        title: Text('Post Flashex', style: TextStyle(color: Colors.white)),
        //meybe add the signout
      ),
      body: Column(children: [
        //the wall
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User Posts')
                .orderBy('TimeStamp', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //data found
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    //get post
                    final post = snapshot.data!.docs[index];
                    return PostCustom(
                      message: post['Message'],
                      user: post['UserEmail'],
                      likes: List<String>.from(post['Likes'] ?? []),
                      postID: post.id,
                      time: formatData(post['TimeStamp']),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                //data not found
                return Text('Error: ${snapshot.error}');
              } else {
                //loading...
                return const LoadingScreen();
              }
            },
          ),
        ),

        //post message
        Row(children: [
          Expanded(
            child: TextFieldCustom(
                controller: postTextController,
                hintText: 'Write something on the here',
                obscureText: false),
          ),
          IconButton(onPressed: postMessage, icon: IconCustomConst.sendPost)
        ]),

        //logged in as
        Text(
          'Logged in as: ${currentUser.email!}',
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/base/helper/helper_methods.dart';
import 'package:flutter_chat_app_basic/core/companent/drawer/drawer.dart';
import 'package:flutter_chat_app_basic/core/companent/loading_screen.dart';
import 'package:flutter_chat_app_basic/core/companent/post_common/post_custom.dart';
import 'package:flutter_chat_app_basic/view/widgets/post_widgets/send_message_text_fild.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final String getMessage =
      FirebaseRemoteConfig.instance.getString('hello_message');
  final String updateMessage =
      FirebaseRemoteConfig.instance.getString('update_message');
  bool? getCon = FirebaseRemoteConfig.instance.getBool("is_update");
  late StreamSubscription<RemoteConfigUpdate> streamSubscription;

  @override
  void initState() {
    super.initState();
    streamSubscription = remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      if (event.updatedKeys.contains("is_update")) {
        //eğer olayda değişen value is_update e eşitse
        bool getUpdateFirebase =
            FirebaseRemoteConfig.instance.getBool("is_update");
        /* if (getUpdateFirebase) {
          dialog(getUpdateFirebase.toString());
        } */
        setState(() {
          getCon = getUpdateFirebase;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return getCon ?? false
        ? Center(child: Text(updateMessage))
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            drawer: const DrawerCustom(),
            appBar: AppBar(
              title: const Text('Post Flashex',
                  style: TextStyle(color: Colors.white)),
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
              const SendMessageTFiled(),
            ]),
          );
  }
}

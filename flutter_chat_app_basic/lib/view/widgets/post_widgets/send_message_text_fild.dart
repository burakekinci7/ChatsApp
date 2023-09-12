import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/text_field_custom.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';
import 'package:flutter_chat_app_basic/core/services/post/post_services.dart';
import 'package:provider/provider.dart';

class SendMessageTFiled extends StatelessWidget {
  const SendMessageTFiled({super.key});

  @override
  Widget build(BuildContext context) {
    //controller
    final TextEditingController postTextController = TextEditingController();

    //current user
    final currentUser = FirebaseAuth.instance.currentUser!;

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

    return Column(
      children: [
        Row(children: [
          Expanded(
            child: TextFieldCustom(
                controller: postTextController,
                hintText: 'Write something on the here',
                obscureText: false,
                textInputType: TextInputType.text,
                isEndTextField: true),
          ),
          IconButton(onPressed: postMessage, icon: IconCustomConst.sendPost)
        ]),
        //logged in as
        Text(
          'Logged in as: ${currentUser.email!}',
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

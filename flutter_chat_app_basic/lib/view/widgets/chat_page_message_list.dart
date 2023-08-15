import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/chat/bubble_chat.dart';
import 'package:flutter_chat_app_basic/core/companent/loading_screen.dart';
import 'package:flutter_chat_app_basic/core/services/chat/chat_service.dart';

mixin ChatMessageList {
  //get instance of auth services nad chat services
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final ChatServices _chatServices = ChatServices();

  static Widget buildMessageList(
      String receiverUserID, ScrollController scrollController) {
    return StreamBuilder(
      stream: _chatServices.getMessages(
          receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Errror: ${snapshot.error.toString()}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList());
      },
    );
  }

  //build message item
  static Widget _buildMessageItem(DocumentSnapshot document) {
    //data is map becasue cloud_firestore
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //return who sent the message
    bool isSendermassge = data['senderId'] == _firebaseAuth.currentUser!.uid;

    Alignment aligment =
        isSendermassge ? Alignment.centerRight : Alignment.centerLeft;

    Timestamp messageTimestamp = data['timestamp'];
    /* messageTimestamp.toDate().minute;
    messageTimestamp.toDate().second;
    messageTimestamp.toDate().hour;
    messageTimestamp.toDate().hour;
    messageTimestamp.toDate().day;
    messageTimestamp.toDate().weekday;
    messageTimestamp.toDate().month;
    messageTimestamp.toDate().year; */

    String getMessage =
        '${messageTimestamp.toDate().hour}:${messageTimestamp.toDate().minute}';

    return Container(
      alignment: aligment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Column(
          crossAxisAlignment: isSendermassge
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            ChatBubble(
                message: data['message'] + ' ' + getMessage,
                isSender: isSendermassge),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/base/model/message.dart';

class ChatServices extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //SEND Message
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create new message (Message Model) tr- message modelin'den yeni bir mesaj oluştur
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    //construct chat rooom id from current user id and receiver id (sorted to ensure uniqueness)
    //tr-gonderen ve alicidan olusan sohbet odasi kimligi olusturun (benzersizlik icin siralayin)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort the ids (this ensures the chat room id is always the same for any pair of people) tr- kimlikleri sırala
    //combine the ids into a single string to use as a chatroomId tr-sohbet odası için kimlikleri birleştir
    String chatRoomId = ids.join('_');

    //add new message to database
    //tr - veritabanına yeni mesaj ekle
    await _firebaseFirestore
        .collection('chats_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET Message  --tr-mesaj gonder
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //construct chat room id from user ids (sorted to ensure it matches the id used when sending messages)
    //tr - kullanıcı kimliklerinden, sohbet odası kimliği oluşturun. kullanilan kimlikle eslenecek sekilde sıralanır
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firebaseFirestore
        .collection('chats_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}

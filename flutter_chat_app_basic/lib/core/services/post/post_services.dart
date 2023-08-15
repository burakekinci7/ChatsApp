import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostService extends ChangeNotifier {
  //get instance of firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //add post store in firebase
  Future<void> addPost(
      String email, String message, Timestamp timestamp) async {
    try {
      await _firebaseFirestore.collection("User Posts").add({
        'UserEmail': email,
        'Message': message,
        'TimeStamp': timestamp,
        'Likes': [],
      });
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  //fav button counter
  void favIncrement(String docId, String email, bool isRemove) {
    _firebaseFirestore.collection("User Posts").doc(docId).update({
      'Likes': isRemove
          ? FieldValue.arrayRemove([email])
          : FieldValue.arrayUnion([email]),
    });
    notifyListeners();
  }

  //add comment for posts
  void addComment(
    String uid,
    String commentText,
    String email,
    Timestamp timesTamp,
  ) {
    _firebaseFirestore
        .collection('User Posts')
        .doc(uid)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentBy': email,
      'CommentTime': timesTamp,
    });
    notifyListeners();
  }

  Future<void> deletePost(String uid) async {
    //delete the comments from firestore first
    final commestDocs = await _firebaseFirestore
        .collection('User Posts')
        .doc(uid)
        .collection('Comments')
        .get();

    for (var doc in commestDocs.docs) {
      await _firebaseFirestore
          .collection('User Posts')
          .doc(uid)
          .collection('Comments')
          .doc(doc.id)
          .delete();
    }

    //then delete the posts
    _firebaseFirestore
        .collection('User Posts')
        .doc(uid)
        .delete()
        .then((value) => print('delete posts'))
        .catchError((errror) => print('Eroorerr : $errror'));

    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/base/helper/helper_methods.dart';
import 'package:flutter_chat_app_basic/core/companent/loading_screen.dart';
import 'package:flutter_chat_app_basic/core/companent/post_common/comment_box.dart';
import 'package:flutter_chat_app_basic/core/companent/post_common/comment_button.dart';
import 'package:flutter_chat_app_basic/core/companent/post_common/fav_button.dart';
import 'package:flutter_chat_app_basic/core/companent/post_common/post_delete.dart';
import 'package:flutter_chat_app_basic/core/services/post/post_services.dart';
import 'package:provider/provider.dart';

class PostCustom extends StatefulWidget {
  final String message;
  final String user;
  final String postID;
  final List<String> likes;
  final String time;

  const PostCustom({
    super.key,
    required this.message,
    required this.user,
    required this.postID,
    required this.likes,
    required this.time,
  });

  @override
  State<PostCustom> createState() => _PostCustomState();
}

class _PostCustomState extends State<PostCustom> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  //toggle like
  void toggleLike() {
    final postSerivce = context.read<PostService>();
    setState(() {
      isLiked = !isLiked;
    });

    if (isLiked) {
      postSerivce.favIncrement(widget.postID, currentUser.email!, false);
    } else {
      postSerivce.favIncrement(widget.postID, currentUser.email!, true);
    }
  }

  //add comment
  void addComment(String commentText) {
    final postSerivce = context.read<PostService>();
    postSerivce.addComment(
      widget.postID,
      commentText,
      currentUser.email.toString(),
      Timestamp.now(),
    );
  }

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Commennt'),
        content: TextField(
          autofocus: true,
          controller: _commentController,
          decoration: InputDecoration(hintText: 'Write a  commnet'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  addComment(_commentController.text);
                  Navigator.pop(context);
                  _commentController.clear();
                }
              },
              child: Text(
                'OKEY',
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                _commentController.clear();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.amber),
              )),
        ],
      ),
    );
  }

  void deletePost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Deleete POstss'),
        content: Text('Are you Sure you want to delete this post?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('CANSEL')),
          TextButton(
              onPressed: () {
                final postSerice = context.read<PostService>();
                postSerice.deletePost(widget.postID);
                Navigator.pop(context);
              },
              child: Text('Delete')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //email and date and delete
          emailDateDelete(),
          //liked button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //comment button
              Column(
                children: [
                  CommentButton(onPressed: showCommentDialog),
                ],
              ),
              //fav button and count
              Row(
                children: [
                  FavButton(
                    isLiked: isLiked,
                    onPressed: toggleLike,
                  ),
                  Text(widget.likes.length.toString()),
                ],
              ),
            ],
          ),
          //comment stream
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User Posts')
                .doc(widget.postID)
                .collection('Comments')
                .orderBy('CommentTime', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LoadingScreen();
              }
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  ///get the commenet
                  final commentData = doc.data() as Map<String, dynamic>;
                  return CommentBox(
                    text: commentData['CommentText'],
                    user: commentData['CommentBy'],
                    time: formatData(commentData['CommentTime']),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }

  Column emailDateDelete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${widget.user} * ',
            ),
            Text(
              widget.time,
            ),
            if (widget.user == currentUser.email)
              PostDelete(onPressed: deletePost)
          ],
        ),
        Text(
          widget.message,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/text_field_custom.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';
import 'package:flutter_chat_app_basic/core/services/chat/chat_service.dart';
import 'package:flutter_chat_app_basic/view/widgets/chat_page_message_list.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String userName;
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
    required this.userName,
  });
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //get instance of chat services
  final ChatServices _chatServices = ChatServices();
  //controller
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

  void sendMessage() async {
    //only send message if there issomething to send. tr-textfield bos degilse gonder
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
      _controller.animateTo(_controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userName)),
      body: Column(
        children: [
          //messages
          Expanded(
            child: ChatMessageList.buildMessageList(
                widget.receiverUserID, _controller),
          ),

          //user message input
          _buildMessageInput(),
        ],
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        //textfield
        Expanded(
          child: TextFieldCustom(
              controller: _messageController,
              hintText: 'Enter to Message',
              obscureText: false,
              isEndTextField: true,
              textInputType: TextInputType.text),
        ),

        //send button
        IconButton(onPressed: sendMessage, icon: IconCustomConst.sendMessage)
      ]),
    );
  }
}

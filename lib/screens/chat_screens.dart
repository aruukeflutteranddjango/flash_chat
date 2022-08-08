import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/models/chat-model.dart';
import 'package:flash_chat/models/user_model.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/widgets/future_chats.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  final String route = 'ChatScreen';
  final UserModel userModel;

  const ChatScreen({Key key, this.userModel}) : super(key: key);
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  String currentUserId = '';
  getCurrentUserId() {
    setState(() {
      final userId = _auth.currentUser;
      currentUserId = userId.uid;
    });
  }

  @override
  void initState() {
    getCurrentUserId();
    super.initState();
  }

  String _message = '';
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()));
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Center(
          child: isClicked
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FutureChats(currentUserId: currentUserId),
                    const SizedBox(),
                    Container(
                      decoration: kMessageContainerDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onChanged: (value) {
                                setState(() {
                                  _message = value;
                                });
                              },
                              decoration: kMessageTextFieldDecoration,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              _controller.clear;
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isClicked = true;
                              });
                              await _addChats();
                            },
                            child: const Text(
                              'Send',
                              style: kSendButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _addChats() async {
    ChatModel chatModel = ChatModel(
        id: widget.userModel.id,
        message: _message,
        createdAt: Timestamp.now(),
        senderEmail: widget.userModel.email,
        senderId: widget.userModel.id);
    setState(() {
      isClicked = false;
    });
    await chatCollection.add(chatModel.toJson());
  }
}

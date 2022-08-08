import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/models/chat-model.dart';

import 'package:flash_chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class FutureChats extends StatelessWidget {
  final String currentUserId;
  // ignore: use_key_in_widget_constructors
  const FutureChats({Key key, @required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: chatCollection.orderBy('createdAt', descending: false).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final chatDataList = snapshot.data.docs;

            return ListView.builder(
                itemCount: chatDataList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ChatModel chatModel =
                      ChatModel.fromJson(chatDataList[index].data());
                  return MessageBubble(
                    isMe: chatModel.senderId == currentUserId,
                    email: chatModel.senderEmail,
                    text: chatModel.message,
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

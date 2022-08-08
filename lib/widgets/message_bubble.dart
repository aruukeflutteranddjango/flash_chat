import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String email;
  final String text;

  const MessageBubble({Key key, this.isMe, this.email, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? const EdgeInsets.only(left: 150)
          : const EdgeInsets.only(right: 150),
      child: Center(
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              email,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
            ),
            Material(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
              elevation: 5.0,
              color: isMe ? Colors.deepOrange : Colors.white,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

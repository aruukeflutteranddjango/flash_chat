
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String message;
  final String senderEmail;
  final String senderId;
  final Timestamp createdAt;
  ChatModel(
      {this.id, this.message, this.senderEmail, this.senderId, this.createdAt});
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        id: json['id'],
        message: json['message'],
        senderEmail: json['senderEmail'],
        senderId: json['senderId'],
        createdAt: json['createdAt']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'senderEmail': senderEmail,
        'senderId': senderId,
        'createdAt': FieldValue.serverTimestamp()
      };
}

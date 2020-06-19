import 'package:flutter/cupertino.dart';

class MessageModel {
  String title;
  String body;
  String message;

  MessageModel({
    @required this.title,
    @required this.body,
    @required this.message,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        title: json['title'],
        body: json['body'],
        message: json['message'],
      );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'message': message,
    };
  }
}

import 'package:flutter/cupertino.dart';

class MessageModel {
  int id;
  String title;
  String body;
  String message;

  MessageModel({
    this.id,
    @required this.title,
    @required this.body,
    @required this.message,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        message: json['message'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'message': message,
    };
  }
}

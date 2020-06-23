import 'package:flutter/cupertino.dart';

class MessageModel {
  int id;
  String title;
  String body;
  String onTitle;
  String onMessage;

  MessageModel({
    this.id,
    @required this.title,
    @required this.body,
    @required this.onTitle,
    @required this.onMessage,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        onTitle: json['onTitle'],
        onMessage: json['onMessage'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'onTitle': onTitle,
      'onMessage': onMessage,
    };
  }
}

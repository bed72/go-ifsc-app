import 'dart:async';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:go_ifsc/app/core/services/sqllite_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBloc extends Disposable {
  final _messageControler = PublishSubject<List<MessageModel>>();

  Stream<List<MessageModel>> get messages => _messageControler.stream;

  void addMessage(MessageModel message) async {
    await DBService.db.create(message);
  }

  void allMessages() async {
    _messageControler.sink.add(await DBService.db.show());
  }

  void deleteMessages(String title) async {
    await DBService.db.delete(title);
  }

  @override
  void dispose() {
    _messageControler.close();
  }
}

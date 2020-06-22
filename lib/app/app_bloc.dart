import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:go_ifsc/app/core/validators/validators.dart';
import 'package:go_ifsc/app/core/services/sqllite_service.dart';

class AppBloc extends Disposable with Validators {
  final _messageControler = PublishSubject<List<MessageModel>>();
  final _detailsControler = PublishSubject<MessageModel>();

  Stream<List<MessageModel>> get messages => _messageControler.stream;
  Stream<MessageModel> get details => _detailsControler.stream;

  void addMessage(MessageModel message) async {
    //print('\n ADD ${message.toMap()} \n');
    await DBService.db.create(message);
    // Attualiza od dados
    allMessages();
  }

  void allMessages() async {
    _messageControler.sink.add(await DBService.db.show());
  }

  void deleteMessages(int id) async {
    // print('\n DELETE $id \n');
    await DBService.db.delete(id);

    // Attualiza od dados
    allMessages();
  }

  void searchMessage(String title) async {
    _messageControler.sink.add(await DBService.db.index(title));
  }

  void searcMessageDetails(String id) async {
    _detailsControler.sink.add(await DBService.db.details(id));
  }

  @override
  void dispose() {
    _messageControler.close();
    _detailsControler.close();
  }
}

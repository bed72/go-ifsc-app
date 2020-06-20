import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:go_ifsc/app/core/validators/validators.dart';
import 'package:go_ifsc/app/core/services/sqllite_service.dart';

class AppBloc extends Disposable with Validators {
  final _messageControler = PublishSubject<List<MessageModel>>();
  final _searchController = BehaviorSubject<String>();

  Stream<List<MessageModel>> get messages => _messageControler.stream;
  // Transformando Stream
  // Caso event que e o conteudo do input de pesquisa > 3 ele irá realizar a pesquisa
  // caso o mesmo seja menor ele ira preencher a lista com o show ou seja
  // todos as notificações
  Stream<String> get getSearch =>
      _searchController.stream.transform(validateSearch).doOnData(
            (event) => event.length <= 3
                ? allMessages()
                : searchMessage(_searchController.value),
          );

  Function(String) get changeSearch => _searchController.sink.add;

  void addMessage(MessageModel message) async {
    print('\n ADD ${message.toMap()} \n');
    await DBService.db.create(message);
  }

  void allMessages() async {
    _messageControler.sink.add(await DBService.db.show());
  }

  void deleteMessages(int id) async {
    print('\n DELETE $id \n');
    // await DBService.db.delete(id);
  }

  void searchMessage(String title) async {
    _messageControler.sink.add(await DBService.db.index(title));
  }

  @override
  void dispose() {
    _messageControler.close();
    _searchController.close();
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/app_bloc.dart';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:go_ifsc/app/core/services/shared_local_storage_service.dart';

class AppPushs extends StatefulWidget {
  AppPushs({
    @required this.child,
  });

  final Widget child;

  @override
  _AppPushsState createState() => _AppPushsState();
}

class _AppPushsState extends State<AppPushs> {
  final appBloc = Modular.get<AppBloc>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  initState() {
    super.initState();
    _initLocalNotifications();
    _initFirebaseMessaging();
    _setTokenFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _initLocalNotifications() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_stat_add_to_home_screen');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  _initFirebaseMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('AppPushs onMessage : $message');
        _setMessageDb(message);
        _showNotification(message);
        return;
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) {
        print('AppPushs onResume : $message');
        _showNotification(message);
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('AppPushs onLaunch : $message');
        return;
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
      ),
    );
  }

  Future _setTokenFirebase() async {
    _firebaseMessaging.getToken().then(
      (String token) async {
        assert(token != null);
        print('\n\nToken Firebase: $token \n\n');
        // Setando token do firebase
        await _changeToken(token);
      },
    );
  }

  // Metodo para setar token do firebase
  Future _changeToken(String token) async {
    await SharedLocalStorageService.localShared.put('tokenFirebase', token);
  }

  // Setando messagem em DB
  void _setMessageDb(Map<String, dynamic> message) async {
    print('\n\n MESSAGE: \n${message.values} \n\n');
    final notification = message['notification'];
    final data = message['data'];

    final String title = notification['title'];
    final String body = notification['body'];
    final String onTitle = data['onTitle'];
    final String onMessage = data['onMessage'];

    MessageModel model = MessageModel(
      title: title,
      body: body,
      onTitle: onTitle,
      onMessage: onMessage,
    );

    appBloc.addMessage(model);
  }

  static Future _showNotification(Map<String, dynamic> message) async {
    var pushTitle;
    var pushText;
    var pushOnTitle;
    var pushOnMessage;
    var action;

    if (Platform.isAndroid) {
      var nodeData = message['data'];
      pushTitle = nodeData['title'];
      pushText = nodeData['body'];
      pushOnTitle = nodeData['onTitle'];
      pushOnMessage = nodeData['onMessage'];
      action = nodeData['action'];
    } else {
      pushTitle = message['title'];
      pushText = message['body'];
      pushOnTitle = message['onTitle'];
      pushOnMessage = message['onMessage'];
      action = message['action'];
    }
    print("\n\nAppPushs params pushTitle: $pushTitle\n\n");
    print("\n\nAppPushs params pushText: $pushText\n\n");
    print("\n\nAppPushs params pushOnTitle: $pushOnTitle\n\n");
    print("\n\nAppPushs params pushOnMessage: $pushOnMessage\n\n");
    print("\n\nAppPushs params pushAction: $action\n\n");

    // @formatter:off
    var platformChannelSpecificsAndroid = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      playSound: false,
      enableVibration: false,
      importance: Importance.Max,
      priority: Priority.High,
    );
    // @formatter:on
    var platformChannelSpecificsIos =
        IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        platformChannelSpecificsAndroid, platformChannelSpecificsIos);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        pushTitle,
        pushText,
        // pushOnTitle,
        // pushOnMessage,
        platformChannelSpecifics,
        payload: 'No_Sound',
      );
    });
  }

  // TOP-LEVEL or STATIC function to handle background messages
  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    print('AppPushs myBackgroundMessageHandler : $message');
    _showNotification(message);
    return Future<void>.value();
  }
}

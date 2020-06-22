import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:go_ifsc/app/app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:go_ifsc/app/core/services/fcm_service.dart';
import 'package:go_ifsc/app/modules/home/widgets/sliver_app_bar_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final appBloc = Modular.get<AppBloc>();
  FcmService _fcmBackgroundMessageHandler = FcmService();

  @override
  void initState() {
    super.initState();
    getNotification();
    appBloc.allMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getNotification() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('\n\nonMessage: $message\n\n');
        _setMessage(message);
      },
      onBackgroundMessage: _fcmBackgroundMessageHandler.,
      onLaunch: (Map<String, dynamic> message) async {
        print('\n\nonLaunch: $message\n\n');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('\n\nonResume: $message\n\n');
        _setMessage(message);
      },
    );
    _fcm.requestNotificationPermissions(
      IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: true,
      ),
    );
    _fcm.onIosSettingsRegistered.listen(
      (IosNotificationSettings settings) {
        print('\n\nConfigurações Registradas: $settings\n\n');
      },
    );
  }

  // Setando messagem em DB
  void _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['message'];

    MessageModel model =
        MessageModel(title: title, body: body, message: mMessage);

    appBloc.addMessage(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, condition) {
          return <Widget>[
            SliverTitleAppBar(
              title: 'Home',
            )
          ];
        },
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                  stream: appBloc.messages,
                  builder:
                      (context, AsyncSnapshot<List<MessageModel>> snapshot) {
                    if (snapshot.hasData) {
                      return _buildList(snapshot);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<List<MessageModel>> snapshot) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 5, bottom: 10),
        primary: true,
        addAutomaticKeepAlives: true,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 1,
            child: ScaleAnimation(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: CardWidget(
                  route: '/home/details/${snapshot.data[index].id}',
                  title: snapshot.data[index].title,
                  body:
                      snapshot.data[index].body ?? snapshot.data[index].message,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

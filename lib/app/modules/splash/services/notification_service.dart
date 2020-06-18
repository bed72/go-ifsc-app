import '../../core/interfaces/notification_viewmodel.dart';

class NotificationService implements INotification {
  @override
  Future onMessage(Map<String, dynamic> message) {
    throw UnimplementedError();
  }

  @override
  Future onLaunch(Map<String, dynamic> message) {
    throw UnimplementedError();
  }

  @override
  Future onResume(Map<String, dynamic> message) {
    throw UnimplementedError();
  }
}

abstract class INotification {
  Future onMessage(Map<String, dynamic> message);
  Future onLaunch(Map<String, dynamic> message);
  Future onResume(Map<String, dynamic> message);
}

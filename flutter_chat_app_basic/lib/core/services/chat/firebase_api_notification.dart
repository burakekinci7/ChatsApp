import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  //create an instance of firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to install notification
  Future<void> initNotification() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();

    //fetch the token
    final fcmToken = await _firebaseMessaging.getToken();

    print('Token $fcmToken');
  }

  //functoin to handle received messaging
  void handleMessaging(RemoteMessage? message) {
    if (message == null) return;

    //global key
    /* navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    ); */
  }

  //function to initalize foreground and background setting
  Future initPush() async {
    //handle notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMessaging);

    //attach event listeners for a notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessaging);
  }
}

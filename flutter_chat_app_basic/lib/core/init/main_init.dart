import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_services.dart';
import 'package:flutter_chat_app_basic/core/services/chat/chat_service.dart';
import 'package:flutter_chat_app_basic/core/services/chat/firebase_api_notification.dart';
import 'package:flutter_chat_app_basic/core/services/firebase/remote_config_service.dart';
import 'package:flutter_chat_app_basic/core/services/post/post_services.dart';
import 'package:flutter_chat_app_basic/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class InitMain {
  static InitMain instance = InitMain();

  //main initialize
  Future<void> initMain() async {
    //use the firebase to min sdkversion 21
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

    //crashlytics -> import pubspec crash
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    //crash end

    //remote config
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  }

  //notification init
  Future<void> initNotification() async {
    await FirebaseApi().initNotification();
  }

  List<SingleChildWidget> porivderList() {
    return [
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
      ChangeNotifierProvider<ChatServices>(create: (context) => ChatServices()),
      ChangeNotifierProvider<PostService>(create: (context) => PostService()),
      ChangeNotifierProvider<RemoteConfigService>(
          create: (context) => RemoteConfigService()),
    ];
  }
}

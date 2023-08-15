import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/firebase_options.dart';

class InitMain {
  //main initialize
  static Future<void> initMain() async {
    //use the firebase to min sdkversion 21
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  }
}

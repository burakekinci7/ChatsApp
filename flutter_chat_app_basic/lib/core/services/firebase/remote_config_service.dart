import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigService extends ChangeNotifier {
  //add the change notifier
  final String getMessage =
      FirebaseRemoteConfig.instance.getString('hello_message');
  bool isUpdate = FirebaseRemoteConfig.instance.getBool('is_update');
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  late StreamSubscription<RemoteConfigUpdate> streamSubscription;

  void listenToUpdate() {
    streamSubscription = remoteConfig.onConfigUpdated.listen((event) async {
      await FirebaseRemoteConfig.instance.activate();
      if (event.updatedKeys.contains("is_update")) {
        bool maintenanceValue =
            FirebaseRemoteConfig.instance.getBool("is_update");
        isUpdate = maintenanceValue;
      }
    });
  }
}

# flutter_chat_app_basic

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

D:\as\jbr\bin\java
# TO DO
- routers
- languege(localization)
- add Photo

# Current package and 
- Firebase
- remote config, crashylitcs, analytics, performance, event, firestore, auth, storage, admob, notification;
- dark and light theme
- state management PROVİDER

# google sign in initilaize
-   Add main if you haven't already
    add main.dart-> WidgetsFlutterBinding.ensureInitialized();
    firebase google enabled
    firebase add sha-1 and sha-256 
    go to project terminal ->   cd android
                                .\gradlew signin Report
                                show the sha1 nad sha256
    android/app/ add the google-services.json
    android/app/builgradle  ->   apply plugin: 'com.google.gms.google-services'
    android/buildgradle ->  classpath 'com.google.gms:google-services:4.3.8'

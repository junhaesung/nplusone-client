// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA5Ggdn5a29uCWa7gnl8LBNs4jvAYrTfnw',
    appId: '1:496948957842:web:c41b04a85494fd278e4c4b',
    messagingSenderId: '496948957842',
    projectId: 'nplusone-3a9c3',
    authDomain: 'nplusone-3a9c3.firebaseapp.com',
    storageBucket: 'nplusone-3a9c3.appspot.com',
    measurementId: 'G-DHQ6150TDE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgvAkoFWpO-JncA9aAdNC7tvuc6We3WbY',
    appId: '1:496948957842:android:464e5f9b43c856928e4c4b',
    messagingSenderId: '496948957842',
    projectId: 'nplusone-3a9c3',
    storageBucket: 'nplusone-3a9c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHlhx1T0-D4xlNOQbyE9oiIGo7TfAiFWU',
    appId: '1:496948957842:ios:17ebb86034fdf7668e4c4b',
    messagingSenderId: '496948957842',
    projectId: 'nplusone-3a9c3',
    storageBucket: 'nplusone-3a9c3.appspot.com',
    androidClientId: '496948957842-0f3gcl30j63nkfeg816a6le1700l1mt1.apps.googleusercontent.com',
    iosClientId: '496948957842-44n7cn42ntedtcu4a7mq9dci1lts6tgs.apps.googleusercontent.com',
    iosBundleId: 'com.haeseong.nplusone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHlhx1T0-D4xlNOQbyE9oiIGo7TfAiFWU',
    appId: '1:496948957842:ios:17ebb86034fdf7668e4c4b',
    messagingSenderId: '496948957842',
    projectId: 'nplusone-3a9c3',
    storageBucket: 'nplusone-3a9c3.appspot.com',
    androidClientId: '496948957842-0f3gcl30j63nkfeg816a6le1700l1mt1.apps.googleusercontent.com',
    iosClientId: '496948957842-44n7cn42ntedtcu4a7mq9dci1lts6tgs.apps.googleusercontent.com',
    iosBundleId: 'com.haeseong.nplusone',
  );
}
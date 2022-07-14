import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/my_http_overrides.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/adapter/storage/token_storage_api.dart';
import 'package:nplusone/app.dart';
import 'package:nplusone/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  late String firebaseUserId;
  try {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    if (kDebugMode) {
      print("Signed in with temporary account. userCredential: $userCredential}");
      firebaseUserId = userCredential.user!.uid;
    }
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        if (kDebugMode) {
          print("Anonymous auth hasn't been enabled for this project.");
        }
        break;
      default:
        if (kDebugMode) {
          print("Unknown error.");
        }
    }
  }
  // 권한 검사. 왜인지 iOS 에만 나옴
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    if (kDebugMode) {
      print('User granted permission');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    if (kDebugMode) {
      print('User granted provisional permission');
    }
  } else {
    if (kDebugMode) {
      print('User declined or has not accepted permission');
    }
  }
  final firebaseToken = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print("token: $firebaseToken");
  }

  // Login
  const api = NplusoneApi();
  final apiResponse = await api.login(firebaseUserId: firebaseUserId);
  if (kDebugMode) {
    print('loginResponse: $apiResponse');
  }

  // Save accessToken
  const tokenStorageApi = TokenStorageApi();
  tokenStorageApi.write(apiResponse.data!.accessToken);

  HttpOverrides.global = MyHttpOverrides();
  runApp(const NplusoneApp());
}

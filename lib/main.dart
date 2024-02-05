import 'package:byme_app/common/utilities/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/utilities/byme_colors.dart';
import 'di/app_injector.dart';
import 'firebase_options.dart';
import 'manager/notifications/push_notifications.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name:'Byme',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  pushNotification.initialise();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  runApp(AppInjector.instance.app);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  printLog('Handling a background message', ' ${message.messageId}');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  pushNotification.remoteNotification();
}

  // print('Handling a background message ${message.messageId}');

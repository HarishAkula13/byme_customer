import 'package:byme_app/common/utilities/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/utilities/byme_colors.dart';
import 'di/app_injector.dart';
import 'firebase_options.dart';
import 'manager/notifications/push_notifications.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotification.initialise();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.getToken().then((value) => printLog("FCM TOKEN", value));
  runApp( MaterialApp(home: AppInjector.instance.app));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //statusBarColor: ByMeColors.white_color, // status bar color
  ));

}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  pushNotification.remoteNotification();

}

  // print('Handling a background message ${message.messageId}');

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/home_screen.dart';

void main() async {
  await AwesomeNotifications().initialize(
      null, [
    NotificationChannel(
        channelKey: 'Basic_Notification_channel_key',
        channelName: 'Basic Notification channel',
        channelDescription: "Here is the channelDescription",
        importance: NotificationImportance.Max)
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

// class NotificationController {

//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
//     // Your code goes here
//   }

//   /// Use this method to detect when the user taps on a notification or action button
//   // @pragma("vm:entry-point")
//   // static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//   //   // Your code goes here

//   //   // Navigate into pages, avoiding to open the notification details page over another details page already opened
//   //   MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
//   //           (route) => (route.settings.name != '/notification-page') || route.isFirst,
//   //       arguments: receivedAction);
//   // }
// }


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

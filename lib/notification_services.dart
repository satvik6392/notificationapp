// import 'dart:js';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notificationapp/message_screen.dart';
// import 'package:app_settings/app_settings.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestnotificationpermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        sound: true,
        provisional: true,
        criticalAlert: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('success');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('provisonal');
    } else {
      print('denied');
    }
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // print("coming here");
    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          handlemessage(context,message);
        });
  }

  void firebaseInit(BuildContext context) async {
    await FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title);
      print(message.notification!.body);
      // print(message.data['type']);
      // print(message.data['id']);  
      initLocalNotifications(context, message);
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        'High Importance Notification',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: 'Channel description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails);
    });
  }

  Future<String?> gettoken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefreshed() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print(event);
    });
  }

  void handlemessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == "msg") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MessageScreen()));
    }
  }
}

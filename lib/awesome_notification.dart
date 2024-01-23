import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createAwesomeNotification() async {
  // print("coming here");
   await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: Random.secure().nextInt(10000),
      channelKey: 'Basic_Notification_channel_key',
      // icon:'images/ic_launcher.png', 
      // icon: 'asset://images/ic_launcher.png',
      title: "Title",
      body: 'Body of Awesome Notification',
    ),
  );
}

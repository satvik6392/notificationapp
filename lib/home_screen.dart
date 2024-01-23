import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
// import 'package:notificationapp/main.dart';
import 'package:notificationapp/notification_services.dart';
import 'package:http/http.dart' as http;

import 'awesome_notification.dart';





class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestnotificationpermission();
    notificationServices.firebaseInit(context);
    // notificationServices.initLocalNotifications();
    notificationServices.isTokenRefreshed();
    notificationServices.gettoken().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    void initState() {
      // super.initState();



    
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Allow Notifications"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Don't Allow")),
                    TextButton(
                        onPressed: () {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) => Navigator.pop(context));
                        },
                        child: Text("Allow")),
                  ],
                );
              });
        } else {}
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  notificationServices.gettoken().then((value) async {
                    var data = {
                      'to': value.toString(),
                      'priority': 'high',
                      'type':'msg',
                      'notification': {
                        'type': 'msg',
                        'title': 'notification',
                        'body': 'hello satvik'
                      }
                    };

                    await http.post(
                      Uri.parse('https://fcm.googleapis.com/fcm/send'),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization':
                            'key=AAAAtdS9sUE:APA91bEdoR600vE7cVD0bp1yKhl20g4NNlSonA-ri2VaMkFthzuhE7HIn9kpc1QiNIT6utQIARRtiVyFOWkReldNoXciT-o_lIs_EKgNyjcNS34rCZ4QHWUFttnlX5QZuYrCInNpQFLg'
                      },
                      body: jsonEncode(data),
                    );
                  });
                },
                child: Text("send to this device")),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: ()async{
                  print("Clicked");
                  await createAwesomeNotification();
                  print("object");
                }, child: Text("Awesome Notification"))
          ],
        ),
      ),
    );
  }
}

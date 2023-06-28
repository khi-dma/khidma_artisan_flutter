import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/snackBar.dart';

class ManagementNotificationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listen();
  }

  listen() async {
    try {
      AwesomeNotifications().initialize(
          null, // icon for your app notification
          [
            NotificationChannel(
              channelKey: 'PLASTI_NOTIFICATION',
              channelName: 'Proto Coders Point',
              channelDescription: "Notification example",
              defaultColor: Color(0XFF9050DD),
              playSound: true,
              enableLights: true,
              enableVibration: true,
            )
          ]);
      await AwesomeNotifications().isNotificationAllowed().then((value) async {
        if(!value){
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });

      FirebaseMessaging.onMessage.listen((message) {
        RemoteNotification? notification = message.notification;
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: DateTime.now().microsecond,
            color: Colors.transparent,
            displayOnBackground: true,
            displayOnForeground: true,
            channelKey: 'PLASTI_NOTIFICATION',
            notificationLayout: NotificationLayout.Inbox,
            hideLargeIconOnExpand: true,
            title: notification!.title,
            body: notification.body,
          ),
        );
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }
}

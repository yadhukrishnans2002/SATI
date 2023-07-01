import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  final onNotification = BehaviorSubject<String?>();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('zector_logo');

    // var initializationSettingsIOS = DarwinInitializationSettings(
    //     requestAlertPermission: true,
    //     requestBadgePermission: true,
    //     requestSoundPermission: true,
    //     onDidReceiveLocalNotification:
    //         (int id, String? title, String? body, String? payload) async {});

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _notifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
    );
  }

  // Future init({bool initSchedule = false}) async {
  //   final android = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final Settings = InitializationSettings(android: android);
  //   await _notifications.initialize(
  //     Settings,
  //     onDidReceiveNotificationResponse:  (payload) async {
  //       onNotification.add(payload);
  //     },
  //   );
  // }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return _notifications.show(id, title, body, await notificationDetails());
  }
}

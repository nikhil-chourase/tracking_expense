import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleDailyNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'daily_expense_reminder_channel',
      'Daily Expense Reminder',
      subText :'',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Record Your Expenses',
      'Don\'t forget to record your expenses for today!',
      const Time(20, 0, 0), // 8:00 PM daily
      platformChannelSpecifics,
    );
  }

   Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  //  Future<void> scheduleMinuteNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'minute_reminder_channel',
  //     'Minute Reminder',
  //     subText:'',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     showWhen: false,
  //   );

  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   // Schedule a notification to repeat every minute
  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     1,
  //     'Record Your Expenses',
  //     'Don\'t forget to record your expenses for today!',
  //     RepeatInterval.everyMinute,
  //     platformChannelSpecifics,
  //   );
  // }



 

 
}




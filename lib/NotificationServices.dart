import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('restaurant');
  void initializationNotification()async{
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  void sendNotification(String title,String body )async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      '...',
      '...',
    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
   await flutterLocalNotificationsPlugin.show(
        0, title, body,
        notificationDetails);
  }
  Future<void> scheduleNotification(String title,String body ,DateTime dateTime,int index,bool isRepeating)async{
    print("Add $index");
    DateTime? scheduleAlarmDateTime;
    if (dateTime.isAfter(DateTime.now()))
      {scheduleAlarmDateTime =dateTime;}
    else
     { scheduleAlarmDateTime = dateTime.add(const Duration(days: 1));}
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      '....',
      '..',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    if(isRepeating){
   await flutterLocalNotificationsPlugin.schedule(
       index, title, body,scheduleAlarmDateTime, notificationDetails,
   androidAllowWhileIdle: true
   );}else{
      flutterLocalNotificationsPlugin.showDailyAtTime(index, title, body, Time(
        scheduleAlarmDateTime.hour,
        scheduleAlarmDateTime.minute,
        scheduleAlarmDateTime.second,
      ), notificationDetails);
    }
  }





  Future<void> deleteNotification(int id) async{
    print('delete $id');
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> scheduleNotificationSnoze(String title,String body ,int hours,int min )async{
    DateTime dateTime=DateTime(2022,12,06,hours,min);
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      '..',
      '..',
    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
   await flutterLocalNotificationsPlugin.zonedSchedule(
       1, title, body,
       tz.TZDateTime.from(DateTime.now().add(Duration(seconds: 30)), tz.local),
       notificationDetails,
       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
       androidAllowWhileIdle: true);
  }
}
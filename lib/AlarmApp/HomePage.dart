import 'package:firebase_notification/AlarmApp/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Expanded(
              child: ListView(
                children: alarms.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.red
                        ),
                        color: Colors.cyan),

                    child:Column(
                      children: [
                        Center(child:Text(e.dateTime.toString())),
                      ],
                    ) ,
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // void scheduleAlarm(DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo, {required bool isRepeating}) async {
  //   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //     'alarm_notif',
  //     'alarm_notif',
  //     channelDescription: 'Channel for Alarm notification',
  //     icon: 'codex_logo',
  //     sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
  //     largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
  //   );
  //
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //   );
  //
  //   if (isRepeating)
  //     await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       0,
  //       'Office',
  //       alarmInfo.title,
  //       Time(
  //         scheduledNotificationDateTime.hour,
  //         scheduledNotificationDateTime.minute,
  //         scheduledNotificationDateTime.second,
  //       ),
  //       platformChannelSpecifics,
  //     );
  //   else
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'Office',
  //       alarmInfo.title,
  //       tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
  //       platformChannelSpecifics,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     );
  // }
}

import 'dart:async';

import 'package:firebase_notification/AlarmApp/Shared_prefrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Alarmapp ShowModelsheet/Hive/user.dart';
import 'Alarmapp ShowModelsheet/HomePageShowSheet.dart';
import 'NotificationServices.dart';
import 'flutterNotifyScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
List<String>? dataL;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('dataModel');
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices=NotificationServices();
  SharedPreference sharedPreference=SharedPreference();
  Future<void> getData() async {
    dataL=await sharedPreference.getList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    notificationServices.initializationNotification();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageShowSheet(),
    );
  }
}
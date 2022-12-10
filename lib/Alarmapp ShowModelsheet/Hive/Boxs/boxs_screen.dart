import 'package:firebase_notification/Alarmapp%20ShowModelsheet/Hive/user.dart';
import 'package:hive/hive.dart';
class BoxesClass{
  static Box<User> getDataModel()=>Hive.box<User>('dataModel');
}
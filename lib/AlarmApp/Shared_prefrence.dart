import 'dart:convert';

import 'package:firebase_notification/AlarmApp/Shared%20Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutterNotifyScreen.dart';
class SharedPreference{
  Future<void> saveList(List<String> list) async{
// Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    print(list.toString());
    await prefs.setStringList('Muz', list);

  }
  Future<List<String>> getList() async{
// Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
     List<String> data2= prefs.getStringList('Muz')!;
     data=data2;
     print(data);
     return data2;
  }
  Future<void> deleteList() async{
// Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
      prefs.remove('Muz');
  }
  Future<void> saveString(String data) async{
// Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Muz', data);

  }
  Future<UserModel> getString() async{
// Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> dataString= jsonDecode(prefs.getString('Muz')!);
   // user=dataString.map((value) => User.fromJson(value));
    return UserModel.fromJson(dataString);
  }

}
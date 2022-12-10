import 'dart:convert';

import 'package:firebase_notification/AlarmApp/Shared%20Model/user.dart';
import 'package:firebase_notification/main.dart';
import 'package:flutter/material.dart';

import 'Shared_prefrence.dart';
class CheckSharedPreference extends StatefulWidget {
  const CheckSharedPreference({Key? key}) : super(key: key);

  @override
  State<CheckSharedPreference> createState() => _CheckSharedPreferenceState();
}

class _CheckSharedPreferenceState extends State<CheckSharedPreference> {
  SharedPreference sharedPreference=SharedPreference();
  TextEditingController  ageEditingController=TextEditingController();
  TextEditingController  nameEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          FloatingActionButton(onPressed: () {
           // sharedPreference.saveList(['1','2','3']);
            UserModel user=UserModel(name: nameEditingController.text,age:ageEditingController.text);
            sharedPreference.saveString(jsonEncode(user));
            setState(() {

            });
          },
          child: Icon(Icons.add),),
          FloatingActionButton(onPressed: () {
            sharedPreference.deleteList();
            setState(() {
            });
          },
          child: Icon(Icons.remove),),
        ],
      ),
      body:Column(
        children: [
          const SizedBox(height: 20,),

          TextField(controller: nameEditingController,),
          const SizedBox(height: 20,),
          TextField(controller: ageEditingController,),
          const SizedBox(height: 20,),
//           FutureBuilder<List<String>>(
//             future:sharedPreference.getList(),
//             builder: (BuildContext context,  snapshot) {
// if(snapshot.data==null){
//   return const Text("Loading......");
// }else {
//   return Expanded(
//     child: ListView.builder(
//       itemCount: snapshot.data!.length,
//       itemBuilder: (context, index) {
//             return Text(snapshot.data![index]);
//       },
//     ),
//   );
// }
//  },
//
//           ),
          FutureBuilder<UserModel>(
            future:sharedPreference.getString(),
            builder: (BuildContext context,  snapshot) {
if(snapshot.data==null){
  return const Text("Loading......");
}else {
  return  Column(
    children: [
      Text(snapshot.data!.name!),
      SizedBox(height: 10,),
      Text(snapshot.data!.age!),
    ],
  );

}
 },
          ),
        ],
      )
    );
  }
}

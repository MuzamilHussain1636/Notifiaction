import 'dart:convert';

import 'package:firebase_notification/AlarmApp/Shared%20Model/user.dart';
import 'package:firebase_notification/AlarmApp/Shared_prefrence.dart';
import 'package:flutter/material.dart';

import 'NotificationServices.dart';
List<String> data=[];
List<UserModel> user=[];
class FlutterNotifyScreen extends StatefulWidget {
  const FlutterNotifyScreen({Key? key}) : super(key: key);

  @override
  State<FlutterNotifyScreen> createState() => _FlutterNotifyScreenState();
}
class _FlutterNotifyScreenState extends State<FlutterNotifyScreen> {
  SharedPreference sharedPreference=SharedPreference();
  NotificationServices notificationServices=NotificationServices();
  int hours=TimeOfDay.now().hour;
  int min=TimeOfDay.now().minute;
  TimeOfDay selectedTime = TimeOfDay.now();
  int? currentIndex;
  bool selected=false;
  int currentSelected = 1;
  List<TimeOfDay> notificationTime = [];
  int height = 50;
  bool isOn=false;

  TextEditingController textEditingController=TextEditingController();
  TextEditingController tEditingController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPreference.getList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterNotifyScreen'),
        centerTitle: true,
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future:sharedPreference.getList(),
                  builder: (context,snapShot){
                    print(snapShot.data!.length,);
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: snapShot.data!.length,
                      itemBuilder: (context,index)=>Text(snapShot.data![index])),
                );
              }),
              // TextButton(
              //   onPressed: () {
              //     notificationServices.sendNotification("Muzamil Hussain","Pakistan is my Country");
              //   },
              //   child: Text("Push Notification"),
              // ),
              // const SizedBox(height: 20,),
              // TextButton(
              //   onPressed: () {
              //     notificationServices.scheduleNotificationSnoze("Muzamil Hussain","Pakistan is my Country",2,4);
              //   },
              //   child: Text("Push Notification Snoz"),
              // ),
              // const SizedBox(height: 20,),
              // TextButton(
              //   onPressed: () {
              //     notificationServices.scheduleNotification("Muzamil Hussain 2","Pakistan is my Country",hours,min,1);
              //   },
              //   child: Text("Push Notification 2"),
              // ),
              // const SizedBox(height: 20,),
              // InkWell(
              //   onTap: (){
              //     _selectTime(context,1);
              //   },
              //   child: Container(
              //     height: 50,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(
              //           color: const Color(0xff9E9E9E)),
              //     ),
              //     child: Padding(
              //       padding:
              //       EdgeInsets.symmetric(horizontal: 20),
              //       child: Row(
              //         children: [
              //           SizedBox(
              //             width: 20.0,
              //           ),
              //           Text(
              //             selectedTime.format(context),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Switch(value: isOn, onChanged: (value){
              //   setState(() {
              //     isOn=!isOn;
              //   });
              // }),
              SizedBox(height: 20,),
              TextField(controller: textEditingController,),
              SizedBox(height: 10,), 
              TextField(controller: tEditingController,),
              SizedBox(height: 10,),
              TextButton(onPressed: (){
                user.add(UserModel(name: textEditingController.text,age: tEditingController.text));
                String usrData=jsonEncode(user);
                data.add(textEditingController.text);
                sharedPreference.saveList(data);
                sharedPreference.saveString(usrData);
              }, child: Text("Save")),
              SizedBox(height: 10,),
              SizedBox(
                height: height.toDouble(),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notificationTime.length + 1,
                    itemBuilder: (context, index) => index ==
                        notificationTime.length
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(
                        //   width: 275.w,
                        //   height: 50.h,
                        //   child: TextFormField(
                        //     controller: textEditingController,
                        //     cursorColor: const Color(0xff5AD6FE),
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: const BorderSide(
                        //             color: Color(0xff9E9E9E)),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: const BorderSide(
                        //             color: Color(0xff9E9E9E)),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: const BorderSide(
                        //             color: Color(0xff9E9E9E)),
                        //       ),
                        //       prefixIcon: Image.asset(
                        //           "assets/Icons/notificationIcon.png"),
                        //       contentPadding: EdgeInsets.only(
                        //           top: 4.h,
                        //           bottom: 4.h,
                        //           left: 30.w,
                        //           right: 10.w),
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: (){
                            selected=false;
                            _selectTime(context,index);
                          },
                          child: Container(
                            height: 50,
                            width: 275,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xff9E9E9E)),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                     selectedTime.format(context),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              height = height + 70;
                              notificationTime
                                  .add(selectedTime);
                              selectedTime=TimeOfDay.now();
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xff9E9E9E)),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xff5AD6FE),
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    )
                        : Column(
                      children: [
                        InkWell(
                          onTap: (){
                            currentIndex=index;
                            selected=true;
                            _selectTime(context,index);

                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xff9E9E9E)),
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    notificationTime[index].format(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future _selectTime(BuildContext context,int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      var selectedDateTime = DateTime(
          now.year, now.month, now.day, picked.hour, picked.minute);
      setState(() {
        hours=picked.hour;
        min=picked.minute;
        selected?{
          notificationTime.removeAt(currentIndex!),
          notificationTime.insert(currentIndex!,picked)
        }
            :
        selectedTime = picked;
      });

        await notificationServices.scheduleNotification("Muzamil Hussain ","Pakistan is my Country",selectedDateTime,index+1,false);
    }
  }
}

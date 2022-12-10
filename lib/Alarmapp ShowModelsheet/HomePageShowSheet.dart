import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../NotificationServices.dart';
import 'Hive/Boxs/boxs_screen.dart';
import 'Hive/user.dart';
class HomePageShowSheet extends StatefulWidget {
  const HomePageShowSheet({Key? key}) : super(key: key);

  @override
  State<HomePageShowSheet> createState() => _HomePageShowSheetState();
}

class _HomePageShowSheetState extends State<HomePageShowSheet> {
  NotificationServices notificationServices=NotificationServices();
  bool _isRepeatSelected = false;
  List<User> userList=[User(data: 'DSA',isRepeating: true)];
  TimeOfDay timeOfDay=TimeOfDay.now();
   String? _alarmTimeString;
  DateTime? _alarmTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Alarm',
              style:
              TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w700, color: Colors.brown, fontSize: 24),
            ),
        ValueListenableBuilder<Box<User>>(
          valueListenable: BoxesClass.getDataModel().listenable(),
          builder: (BuildContext context, box, Widget? child) {
            final dataUserBuilder = box.values.toList().cast<User>();
            return Expanded(
              child: ListView.builder(
                  itemCount: dataUserBuilder.length+1,
                  itemBuilder: (context,index)=>
                    index !=
                        dataUserBuilder.length
                        ? Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: const BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: const <Widget>[
                                  Icon(
                                    Icons.label,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text("Repeated",
                                    style: TextStyle(color: Colors.white, fontFamily: 'avenir'),
                                  ),
                                ],
                              ),
                              Switch(
                                onChanged: (bool value) {},
                                value:dataUserBuilder[index].isRepeating??false,
                                activeColor: Colors.white,
                              ),
                            ],
                          ),
                          const Text(
                            'Mon-Fri',
                            style: TextStyle(color: Colors.black, fontFamily: 'avenir'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(dataUserBuilder[index].data!,
                                //alarmTime,
                                style: const TextStyle(
                                    color: Colors.white, fontFamily: 'avenir', fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.white,
                                  onPressed: ()async {
                                    deleteTransaction(dataUserBuilder[index]);
                                await notificationServices.deleteNotification(index);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ): Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        onPressed: () {
                          // _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
                          showModalBottomSheet(
                            useRootNavigator: true,
                            context: context,
                            clipBehavior: Clip.antiAlias,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setModalState) {
                                  return Container(
                                    padding: const EdgeInsets.all(32),
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            var selectedTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (selectedTime != null) {
                                              final now = DateTime.now();
                                              var selectedDateTime = DateTime(
                                                  now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                                              _alarmTime = selectedDateTime;
                                              setModalState(() {
                                                _alarmTimeString = DateFormat('HH:mm').format(selectedDateTime);
                                              });
                                            }
                                          },
                                          child: Text(
                                            _alarmTimeString??"Select Time",
                                            style: const TextStyle(fontSize: 32),
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text('Repeat'),
                                          trailing: Switch(
                                            onChanged: (value) {
                                              setModalState(() {
                                                _isRepeatSelected = value;
                                              });
                                            },
                                            value: _isRepeatSelected,
                                          ),
                                        ),
                                        const SizedBox(height: 20,),
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            addData(_alarmTimeString!,_isRepeatSelected);
                                            notificationServices.scheduleNotification("Muzamil Hussain", "Pakistan Is my country",_alarmTime!,index,_isRepeatSelected);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.alarm),
                                          label: const Text('Save'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                          // scheduleAlarm();
                        },
                        child: const Text(
                          'Add Alarm',
                          style: TextStyle(color: Colors.white, fontFamily: 'avenir'),
                        ),
                      ),
                    )

                  ),
            );
          },
        )
          ],
        ),
      ),
    );
  }
  void addData(String data, bool isRepeated) {
    final userData = User(data: data,isRepeating:isRepeated );
    final box = BoxesClass.getDataModel();
    box.add(userData);
  }
  void editedData(
      User userData,
      String data,
      bool isRepeated
      ){
    userData.data=data;
    userData.isRepeating=isRepeated;
    userData.save();
  }
  void deleteTransaction(User userModel) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    userModel.delete();
    //setState(() => transactions.remove(transaction));
  }
}

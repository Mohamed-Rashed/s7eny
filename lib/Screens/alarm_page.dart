import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s7eny/Screens/widget/notification_services.dart';
import 'package:s7eny/alarm_helper.dart';
import 'package:s7eny/const/colors.dart';
import 'package:s7eny/data.dart';
import 'package:s7eny/models/alarm_info.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late DateTime _alarmTime;
  late String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  var _currentAlarms;

  @override
  void initState() {
    super.initState();
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    tz.initializeTimeZones();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    NotificationService().showNotification(
        0, alarmInfo.title, "${DateTime.now()}", scheduleAlarmDateTime);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Alarm",
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: MyColor.primaryTextColor,
                fontSize: 24,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<AlarmInfo>>(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _currentAlarms = snapshot.data;
                    return ListView(
                      children: snapshot.data!.map<Widget>((alarm) {
                        var alarmTime =
                        DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                        var gradientColor = GradientTemplate
                            .gradientTemplate[alarm.gradientColorIndex!].colors;
                        return Container(
                          margin: EdgeInsets.only(bottom: 32),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColor,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: gradientColor.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.label,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Office",
                                        style: TextStyle(
                                          fontFamily: 'avenir',
                                          color: MyColor.primaryTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Switch(
                                    onChanged: (bool value) {},
                                    value: true,
                                    activeColor: Colors.white,
                                  ),
                                ],
                              ),
                              Text(
                                "Mon-Fri",
                                style: TextStyle(
                                  fontFamily: 'avenir',
                                  color: MyColor.primaryTextColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    alarmTime,
                                    style: TextStyle(
                                      fontFamily: 'avenir',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: MyColor.primaryTextColor,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.white,
                                      onPressed: () {
                                        deleteAlarm(alarm.id!);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).followedBy([
                        _currentAlarms.length < 5
                            ? DottedBorder(
                                strokeWidth: 2,
                                color: MyColor.clockOutline,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(24),
                                dashPattern: [5, 4],
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: MyColor.clockBG,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child: FlatButton(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16,
                                    ),
                                    onPressed: () {
                                      _alarmTimeString = DateFormat('HH:mm')
                                          .format(DateTime.now());
                                      showModalBottomSheet(
                                        useRootNavigator: true,
                                        context: context,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(24),
                                          ),
                                        ),
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setModalState) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(32),
                                                child: Column(
                                                  children: [
                                                    FlatButton(
                                                      onPressed: () async {
                                                        var selectedTime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (selectedTime !=
                                                            null) {
                                                          final now =
                                                              DateTime.now();
                                                          var selectedDateTime =
                                                              DateTime(
                                                                  now.year,
                                                                  now.month,
                                                                  now.day,
                                                                  selectedTime
                                                                      .hour,
                                                                  selectedTime
                                                                      .minute);
                                                          _alarmTime =
                                                              selectedDateTime;
                                                          setModalState(() {
                                                            _alarmTimeString =
                                                                DateFormat(
                                                                        'HH:mm')
                                                                    .format(
                                                                        selectedDateTime);
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        _alarmTimeString,
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text('Repeat'),
                                                      trailing: Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                    ListTile(
                                                      title: Text('Sound'),
                                                      trailing: Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                    ListTile(
                                                      title: Text('Title'),
                                                      trailing: Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                    FloatingActionButton
                                                        .extended(
                                                      onPressed: onSaveAlarm,
                                                      icon: Icon(Icons.alarm),
                                                      label: Text('Save'),
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
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/add_alarm.png',
                                          scale: 1.5,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Add Alarm",
                                          style: TextStyle(
                                            fontFamily: 'avenir',
                                            color: MyColor.primaryTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                'Only 5 alarms allowed!',
                                style: TextStyle(color: Colors.white),
                              )),
                      ]).toList(),
                    );
                  }
                  return Center(
                    child: Text(
                      'Loading..',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

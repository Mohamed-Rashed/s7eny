import 'package:flutter/material.dart';
import 'package:s7eny/const/colors.dart';
import 'package:s7eny/data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
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
              child: ListView(
                children: alarms.map((alarm) {
                  var gradientColor = GradientTemplate
                      .gradientTemplate[alarm.gradientColorIndex!].colors;
                  return Container(
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "07:00 AM",
                              style: TextStyle(
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: MyColor.primaryTextColor,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 36,
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

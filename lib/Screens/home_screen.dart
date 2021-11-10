import 'package:flutter/material.dart';
import 'package:s7eny/Screens/widget/clock_view.dart';
import 'package:s7eny/const/colors.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timeZoneString.startsWith('-')) offsetSign = '+';
    return Scaffold(
      backgroundColor: MyColor.mainColor,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildMenuButton('Clock', 'assets/clock_icon.png'),
              buildMenuButton('Alarm', 'assets/alarm_icon.png'),
              buildMenuButton('Timer', 'assets/timer_icon.png'),
              buildMenuButton('Stopwatch', 'assets/stopwatch_icon.png'),
            ],
          ),
          VerticalDivider(
            color: MyColor.dividerColor,
            width: 1,
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Clock",
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      formattedTime,
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: Colors.white,
                        fontSize: 64,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    ClockView(),
                    Text(
                      "Time Zone",
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "UTC" + offsetSign + timeZoneString,
                          style: TextStyle(
                            fontFamily: 'avenir',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildMenuButton(String title, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: TextButton(
        onPressed: () {},
        child: Column(
          children: [
            Image.asset(
              image,
              scale: 1.5,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'avenir',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

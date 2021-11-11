import 'package:flutter/material.dart';
import 'package:s7eny/const/colors.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Clock",
            style: TextStyle(
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              color: MyColor.primaryTextColor,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s7eny/Screens/alarm_page.dart';
import 'package:s7eny/Screens/clock_page.dart';
import 'package:s7eny/const/colors.dart';
import 'package:s7eny/data.dart';
import 'package:s7eny/enum.dart';
import 'package:s7eny/models/menu_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.mainColor,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: MyColor.dividerColor,
            width: 1,
          ),
          Expanded(
            child: Consumer(
              builder: (BuildContext context,MenuInfo value, Widget? child) {
                if(value.menuType == MenuType.clock) return ClockPage();
                else if(value.menuType == MenuType.alarm) return AlarmPage();
                else return Container();
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(32)),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                  currentMenuInfo.menuType == value.menuType
                      ? MyColor.menuBackgroundColor
                      : Colors.transparent),
            ),
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(
              children: [
                Image.asset(
                  currentMenuInfo.imageSource!,
                  scale: 1.5,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  currentMenuInfo.title!,
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
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s7eny/Screens/home_screen.dart';
import 'package:s7eny/Screens/widget/notification_services.dart';
import 'package:s7eny/enum.dart';
import 'package:s7eny/models/menu_info.dart';

void main() {
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<MenuInfo>(
          create: (context) => MenuInfo(MenuType.clock), child: HomePage()),
    );
  }
}

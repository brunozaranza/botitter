import 'package:bottiter/core/store/bot_new_store.dart';
import 'package:bottiter/core/store/home_store.dart';
import 'package:bottiter/ui/page/bottom_navigation_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<HomeStore>.value(value: HomeStore()),
      Provider<BotNewStore>.value(value: BotNewStore()),
    ],
    child: BottiterApp(),
  ));
}

class BottiterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boticário Microblogging',
      theme: ThemeData(
        fontFamily: "Raleway",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavigationBarPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

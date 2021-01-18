import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/repository/database/database.dart';
import 'package:bottiter/core/store/bot_new_store.dart';
import 'package:bottiter/core/store/home_store.dart';
import 'package:bottiter/core/store/user_store.dart';
import 'package:bottiter/core/viewmodel/bot_new_viewmodel.dart';
import 'package:bottiter/core/viewmodel/home_viewmodel.dart';
import 'package:bottiter/core/viewmodel/login_viewmodel.dart';
import 'package:bottiter/ui/page/bottom_navigation_bar_page.dart';
import 'package:bottiter/ui/page/login_page.dart';
import 'package:bottiter/ui/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<LoginViewModel>.value(value: LoginViewModel(store: UserStore())),
      Provider<HomeViewModel>.value(value: HomeViewModel(store: HomeStore())),
      Provider<BotNewViewModel>.value(
          value: BotNewViewModel(store: BotNewStore())),
    ],
    child: BottiterApp(),
  ));
}

class BottiterApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boticário Microblogging',
      theme: ThemeData(
        fontFamily: "Raleway",
        primaryColor: Colors.white,
        accentColor: Colors.grey.shade100,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

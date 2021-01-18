import 'dart:async';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/repository/database/database.dart';
import 'package:bottiter/core/viewmodel/login_viewmodel.dart';
import 'package:bottiter/ui/page/bottom_navigation_bar_page.dart';
import 'package:bottiter/ui/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashDelay = 3;

  LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return FutureBuilder(
        future: Database.getUser(),
        builder: (_, AsyncSnapshot<User> snap) {
          if (snap.data == null) {
            return LoginPage();
          }

          _loginViewModel.user = snap.data;

          return BottomNavigationBarPage();
        },
      );
    }));  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {

    _loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/zaranza.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 16),
              Text(
                "BRUNO ZARANZA",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
              SizedBox(height: 3),
              Text(
                "brunozaranza@gmail.com",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                "+55 85 99793-4124",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 50, right: 50),
                child: Text(
                  "Cearense, criativo, desenrolado e desenvolvedor de apps.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

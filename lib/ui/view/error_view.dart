import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotErrorView extends StatelessWidget {
  final String msg;
  final Function() onTap;

  BotErrorView({this.msg, @required this.onTap});

  _body() {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 70,
              ),
              SizedBox(height: 48),
              Text(
                msg ?? "Houve um erro",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "Toque para atualizar",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 45,
          child: Image.asset("assets/images/logo.png"),
        ),
        centerTitle: true,
      ),
      body: _body(),
    );
  }
}

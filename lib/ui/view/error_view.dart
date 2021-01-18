import 'package:flutter/material.dart';

class BotErrorView extends StatefulWidget {

  final String msg;

  BotErrorView({this.msg});

  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<BotErrorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(widget.msg?? "Houve um erro"),
      ),
    );
  }
}

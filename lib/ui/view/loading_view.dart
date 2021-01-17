import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final String text;
  final double value;
  final double stroke;
  final Color backgroundColor;
  final double size;

  LoadingView({
    this.text,
    this.value,
    this.stroke = 4.0,
    this.backgroundColor,
    this.size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: stroke,
                backgroundColor: backgroundColor,
              ),
            ),
            SizedBox(height: 8),
            Text(text?? "Carregando..."),
          ],
        ),
      ),
    );
  }
}

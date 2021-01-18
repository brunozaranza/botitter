import 'package:flutter/material.dart';

class BotTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool password;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final Size size;

  BotTextFormField({
    @required this.label,
    this.hint,
    this.password = false,
    this.icon,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          width: size == null ? double.maxFinite : (size.width/2) - 25,
          child: TextFormField(
            controller: controller,
            obscureText: password,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            focusNode: focusNode,
            onFieldSubmitted: (String text) {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              }
            },
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: BotInputDecoration(),
          ),
        ),
      ],
    );
  }

  InputDecoration BotInputDecoration() {
    return icon != null
        ? InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(top: 14.0),
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.white,
      ),
    )
        : InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(10.0),
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.white,
      ),
    );
  }
}



import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroungcolor;
  final Color bordercolor;
  final Color textcolor;
  final String text;
  const FollowButton(
      {Key? key,
      required this.backgroungcolor,
      required this.bordercolor,
      required this.text,
      required this.textcolor,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2,
      ),
      child: TextButton(
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
              color: backgroungcolor,
              border: Border.all(color: bordercolor),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 250,
          height: 32,
        ),
      ),
    );
  }
}

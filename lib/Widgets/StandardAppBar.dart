import 'package:flutter/material.dart';

Widget standardAppBar(String title, BuildContext context, Color color,
    IconData icon, Function onPressed, actions) {
  return AppBar(
      leadingWidth: 40,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Ink(
          child: IconButton(
            onPressed: () {
              onPressed();
            },
            icon: Builder(
              builder: (themeContext) {
                return Icon(
                  icon,
                  color: color,
                  size: 25,
                );
              },
            ),
          ),
        ),
      ),
      actions: actions,
      title: Builder(
        builder: (themeContext) {
          return Text(title,
              style: TextStyle(
                  fontFamily: 'ProximaNova',
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: color));
        },
      ));
}

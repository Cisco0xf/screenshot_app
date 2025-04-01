import 'package:flutter/material.dart';

RoundedRectangleBorder roundedBorder({
  double radius = 20,
  Color color = const Color(0xFF000000),
  double thikness = 0.0,
}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
    side: BorderSide(
      color: color,
      width: thikness,
    ),
  );
}

EdgeInsetsGeometry padding({double padding = 10.0}) => EdgeInsets.all(padding);

BorderRadius borderRadius({double radius = 25}) =>
    BorderRadius.circular(radius);

OutlinedButtonThemeData buttonThemeData({
  Color borderColor = const Color(0xFFFFFFFF),
  double borderThikness = 1.5,
  double radius = 25,
}) =>
    OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: borderColor,
            width: borderThikness,
          ),
        ),
      ),
    );

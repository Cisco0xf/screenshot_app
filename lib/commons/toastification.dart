import 'package:flutter/material.dart';
import 'package:screenshotapp/commons/navigator_key.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:toastification/toastification.dart';

TextStyle toastStyle({
  double fontSize = 14,
  bool isBold = false,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: isBold ? FontWeight.bold : null,
    fontFamily: FontFamily.mainFont,
  );
}

void showToastification({
  ToastificationType type = ToastificationType.info,
  String? title,
  required String msg,
}) {
  final BuildContext context = navigatorKey.currentContext as BuildContext;
  toastification.show(
    context: context,
    title: title != null
        ? Text(
            title,
            style: toastStyle(fontSize: 16, isBold: true),
          )
        : null,
    description: Text(
      msg,
      style: toastStyle(),
    ),
    type: type,
    closeButtonShowType: CloseButtonShowType.none,
    applyBlurEffect: true,
    showProgressBar: false,
    alignment: Alignment.topCenter,
    animationDuration: const Duration(milliseconds: 300),
    autoCloseDuration: const Duration(milliseconds: 2500),
  );
}

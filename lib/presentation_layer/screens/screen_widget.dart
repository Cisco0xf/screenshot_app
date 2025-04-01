import 'package:flutter/material.dart';
import 'package:screenshotapp/commons/gaps.dart';
import 'package:screenshotapp/constants/fonts.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const FlutterLogo(size: 200),
        context.gapH2,
        const Text(
          "Cupture Full Screen",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.mainFont,
          ),
        ),
      ],
    );
  }
}

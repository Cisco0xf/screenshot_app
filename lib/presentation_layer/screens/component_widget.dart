import 'package:flutter/material.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/commons/gaps.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:screenshotapp/presentation_layer/screens/dialog_widget.dart';

class ComponentWidget extends StatelessWidget {
  const ComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: padding(),
          width: context.screenWidth,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: borderRadius(radius: 20.0),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius(radius: 20),
              onTap: () {
                showScreenshotDialog;
              },
              child: Padding(
                padding: padding(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const FlutterLogo(
                      size: 100,
                    ),
                    context.gapH1,
                    const Text(
                      "Show Screenshot Dialog",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.subFont,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

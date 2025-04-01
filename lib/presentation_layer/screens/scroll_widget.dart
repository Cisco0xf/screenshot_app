import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:screenshotapp/presentation_layer/components/screenshot_widget.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_provider.dart';

/// In Taking screenshot for the screollable widget
/// the scrollable widget must be the parent of the ScreenShot Widget [Important]

class ScrollWidget extends StatelessWidget {
  const ScrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageScreenshot screenshot = Provider.of<ManageScreenshot>(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding:
                EdgeInsets.only(bottom: context.screenHeight * .16, top: 15.0),
            child: Container(
              padding: screenshot.scrollBorder ? padding() : null,
              margin: screenshot.scrollBorder ? padding() : null,
              decoration: BoxDecoration(
                borderRadius: borderRadius(radius: 15.0),
                border: screenshot.scrollBorder
                    ? Border.all(color: Colors.white, width: 2.0)
                    : null,
              ),
              child: TakeScreenshot(
                child: Column(
                  children: <Widget>[
                    for (int index = 1; index <= 30; index++) ...{
                      Container(
                        padding: padding(),
                        margin: padding(),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius(radius: 15.0),
                          color: AppColors.primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Item $index",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontFamily.subFont,
                                color: index % 2 == 0
                                    ? AppColors.textMainColor
                                    : Colors.deepOrange,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    },
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

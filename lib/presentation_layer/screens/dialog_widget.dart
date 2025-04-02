import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/commons/navigator_key.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:screenshotapp/constants/pathes.dart';
import 'package:screenshotapp/constants/texts.dart';
import 'package:screenshotapp/presentation_layer/components/animated_counter.dart';
import 'package:screenshotapp/presentation_layer/components/screenshot_widget.dart';
import 'package:screenshotapp/presentation_layer/components/show_screenshot_img.dart';
import 'package:screenshotapp/state_management_layer/pages_provider/select_screen_provider.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_provider.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_settings.dart';

import 'package:screenshotapp/commons/gaps.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({super.key});

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

const TextStyle contentStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  fontFamily: FontFamily.mainFont,
);

Future<void> get showScreenshotDialog async {
  final BuildContext context = navigatorKey.currentContext as BuildContext;

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Consumer<SelectTargetProvider>(
          builder: (context, currentScreen, _) {
            return Consumer<ManageScreenshot>(
              builder: (context, screenshot, _) {
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          log("Outer part of the Dialog Tapped");
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          log("Dialog Tapped");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: context.screenHeight * .6,
                              child: GestureDetector(
                                onDoubleTap: () async {
                                  final SettingsProvider settings =
                                      Provider.of<SettingsProvider>(
                                    context,
                                    listen: false,
                                  );

                                  bool showCounter = settings.showCounter;

                                  if (!showCounter) {
                                    await screenshot.cuptureScreenshot;

                                    return;
                                  }

                                  await screenshot.startShot;
                                },
                                child: Container(
                                  margin: screenshot.dialogBorder
                                      ? padding()
                                      : null,
                                  padding: screenshot.dialogBorder
                                      ? padding()
                                      : null,
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius(radius: 15.0),
                                    border: screenshot.dialogBorder
                                        ? Border.all(
                                            color: Colors.white,
                                            width: 2.0,
                                          )
                                        : null,
                                  ),
                                  child: TakeScreenshot(
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          bottom: 0.0,
                                          right: 20,
                                          left: 20,
                                          top: 48,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.only(
                                                  top: 48,
                                                  left: 10.0,
                                                  bottom: 5.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      borderRadius(radius: 20),
                                                ),
                                                child: const DialogContent(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Positioned.fill(
                                          bottom: null,
                                          child: CircleAvatar(
                                            radius: 48,
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundImage: AssetImage(
                                                Paths.image,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (screenshot.showCountDown && currentScreen.isDialog) ...{
                      const AnimatedCounter(
                        fromDialog: true,
                      )
                    },
                    if (screenshot.showScreenshotImg &&
                        currentScreen.isDialog) ...{
                      const ShowScreenshotImageWidget()
                    },
                  ],
                );
              },
            );
          },
        ),
      );
    },
  );
}

class DialogContent extends StatelessWidget {
  const DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "About This App",
              style: TextStyle(
                fontSize: 19,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                color: AppColors.textMainColor,
                fontFamily: FontFamily.subFont,
              ),
            ),
          ],
        ),
        Text(
          aboutApp,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontFamily: FontFamily.mainFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(height: 10.0, endIndent: 10.0),
        Text(
          content1,
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textMainColor,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.subFont,
          ),
        ),
        Text(content2, style: contentStyle),
        Text(content3, style: contentStyle),
        Text(content4, style: contentStyle),
        Text(content5, style: contentStyle),
        Divider(height: 10.0, endIndent: 10.0),
        Text(
          content6,
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textMainColor,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.subFont,
          ),
        ),
        Text(content7, style: contentStyle),
        Text(content8, style: contentStyle),
        Text(content9, style: contentStyle),
      ],
    );
  }
}

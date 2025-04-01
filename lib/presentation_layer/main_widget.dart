import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/presentation_layer/components/animated_counter.dart';
import 'package:screenshotapp/presentation_layer/components/custom_app_bar.dart';
import 'package:screenshotapp/presentation_layer/components/screenshot_widget.dart';
import 'package:screenshotapp/presentation_layer/components/show_screenshot_img.dart';
import 'package:screenshotapp/presentation_layer/components/custom_tap_bar/model.dart';
import 'package:screenshotapp/presentation_layer/components/custom_tap_bar/taps_view.dart';
import 'package:screenshotapp/state_management_layer/pages_provider/select_screen_provider.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_provider.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_settings.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectTargetProvider>(
      builder: (context, currentScreen, _) {
        return Consumer<SettingsProvider>(
          builder: (context, invokeScreenshot, _) {
            return Consumer<ManageScreenshot>(
              builder: (context, screenshot, _) {
                return Container(
                  padding: screenshot.fullBorder ? padding() : null,
                  margin: screenshot.fullBorder ? padding() : null,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius(radius: 15.0),
                    border: screenshot.fullBorder
                        ? Border.all(color: Colors.white, width: 2.0)
                        : null,
                  ),
                  child: PopScope(
                    canPop: !screenshot.showScreenshotImg,
                    child: GestureDetector(
                      onDoubleTap: () async {
                        if (!invokeScreenshot.withDoubleTaps ||
                            screenshot.showScreenshotImg) {
                          log("Double Taps Methods disabled !!");
                          return;
                        }

                        if (!invokeScreenshot.showCounter) {
                          await screenshot.cuptureScreenshot;
                          return;
                        }
                        await screenshot.startShot;
                      },
                      child: TakeScreenshot(
                        child: Scaffold(
                          body: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                top: context.screenHeight * .18,
                                child: taps[currentScreen.currentTarget]
                                    .targetWidget,
                              ),
                              const CustomAppBar(),
                              const CustomTapBar(),
                              if (screenshot.showCountDown &&
                                  !currentScreen.isDialog) ...{
                                const AnimatedCounter()
                              },
                              if (screenshot.showScreenshotImg &&
                                  !currentScreen.isDialog) ...{
                                const ShowScreenshotImageWidget()
                              },
                            ],
                          ),
                          floatingActionButton:
                              !invokeScreenshot.withDoubleTaps &&
                                      !screenshot.showScreenshotImg
                                  ? FloatingActionButton(
                                      child: const Icon(Icons.screenshot),
                                      onPressed: () async {
                                        if (!invokeScreenshot.showCounter) {
                                          await screenshot.cuptureScreenshot;
                                          return;
                                        }
                                        await screenshot.startShot;
                                      },
                                    )
                                  : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

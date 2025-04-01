import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/commons/gaps.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_provider.dart';

class ShowScreenshotImageWidget extends StatefulWidget {
  const ShowScreenshotImageWidget({super.key});

  @override
  State<ShowScreenshotImageWidget> createState() =>
      _ShowScreenshotImageWidgetState();
}

class _ShowScreenshotImageWidgetState extends State<ShowScreenshotImageWidget> {
  final GlobalKey heightKey = GlobalKey();

  double widgetHeight = 0.0;

  void get catchHeight {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final BuildContext? hContext = heightKey.currentContext;

        if (hContext == null) {
          log("Context is Null !!");
          return;
        }

        final RenderBox box = hContext.findRenderObject() as RenderBox;

        final double catchedHeight = box.size.height;

        setState(
          () {
            widgetHeight = catchedHeight;
          },
        );

        log("Widget Height : $widgetHeight");
      },
    );
  }

  @override
  void initState() {
    catchHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Height of the Widget : $widgetHeight");
    return Positioned.fill(
      child: Consumer<ManageScreenshot>(
        builder: (context, img, _) {
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                bottom: widgetHeight - 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: context.screenHeight * .7,
                      width: context.screenWidth * .95,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius(radius: 15.0),
                      ),
                      child: InteractiveViewer(
                        maxScale: 4.0,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0.5, end: 1.0),
                          duration: const Duration(milliseconds: 700),
                          builder: (context, animatedScale, _) {
                            return Transform.scale(
                              scale: animatedScale,
                              child: Image.memory(img.shownScreenshot!),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 0.0,
                left: 0.0,
                child: Column(
                  key: heightKey,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          height: context.screenHeight * .07,
                          width: context.screenWidth * .3,
                          child: OutlinedButtonTheme(
                            data: buttonThemeData(),
                            child: OutlinedButton(
                              onPressed: () {
                                img.hideImage;
                              },
                              child: const Text("CANCEL"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.screenHeight * .07,
                          width: context.screenWidth * .3,
                          child: MaterialButton(
                            onPressed: () async {
                              await img.saveImageToGallery;
                              img.hideImage;
                            },
                            color: AppColors.secondaryColor,
                            shape: roundedBorder(
                              color: const Color(0xFFFFFFFF),
                              thikness: 1.0,
                              radius: 25,
                            ),
                            child: const Text("Save"),
                          ),
                        ),
                      ],
                    ),
                    context.gapH2,
                    SizedBox(
                      height: context.screenHeight * .07,
                      width: context.screenWidth * .8,
                      child: MaterialButton(
                        onPressed: () async {
                          await img.shareAndSave;
                        },
                        shape: roundedBorder(
                          radius: 25,
                          color: Colors.white,
                          thikness: 1.5,
                        ),
                        color: const Color(0xFF0C0E2D),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.share),
                            context.gapW2,
                            const Text(
                              "Save & Share",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00FFE0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

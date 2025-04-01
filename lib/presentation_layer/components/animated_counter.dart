import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_provider.dart';

class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    super.key,
    this.fromDialog = false,
  });

  final bool fromDialog;

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageScreenshot>(
      builder: (context, screenshot, _) {
        return Positioned.fill(
          top: fromDialog ? 0.0 : context.screenHeight * .25,
          child: Column(
            children: <Widget>[
              Opacity(
                opacity: 0.7,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(
                    begin: screenshot.textProperties.$1,
                    end: screenshot.textProperties.$1,
                  ),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, _) {
                    return AnimatedOpacity(
                      opacity: screenshot.textProperties.$2,
                      duration: const Duration(seconds: 1),
                      child: Text(
                        screenshot.countDown.toString(),
                        style: TextStyle(
                          fontSize: value,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMainColor,
                          fontFamily: FontFamily.roboticFont,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

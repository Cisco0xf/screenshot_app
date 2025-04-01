import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_provider.dart';

class TakeScreenshot extends StatelessWidget {
  const TakeScreenshot({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageScreenshot>(
      builder: (context, border, _) {
        return Screenshot(
          controller: ManageScreenshot.screenShotController,
          child: child,
        );
      },
    );
  }
}

// Height Gaps

import 'package:flutter/material.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';

extension Gaps on BuildContext {
  SizedBox get gapH1 => SizedBox(height: screenHeight * .01);

  SizedBox get gapH2 => SizedBox(height: screenHeight * .02);

  SizedBox get gapH3 => SizedBox(height: screenHeight * .03);

// Width Gaps

  SizedBox get gapW2 => SizedBox(width: screenWidth * .02);
}

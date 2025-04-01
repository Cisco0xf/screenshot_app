import 'package:flutter/material.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/constants/texts.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:screenshotapp/presentation_layer/components/settings_dialog.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: null,
      child: Container(
        height: context.screenHeight * .16,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              top: context.screenHeight * .05,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    appTitle,
                    style: TextStyle(
                      fontFamily: FontFamily.mainFont,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * .05,
              right: 10,
              child: IconButton(
                onPressed: () async {
                  await showSettinsDialog;
                },
                icon: const Icon(
                  Icons.settings,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

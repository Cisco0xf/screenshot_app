import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/commons/gaps.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:screenshotapp/constants/pathes.dart';
import 'package:screenshotapp/presentation_layer/components/screenshot_widget.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_provider.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageScreenshot screenshot = Provider.of<ManageScreenshot>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          context.gapH3,
          Container(
            padding: screenshot.imageBorder ? padding() : null,
            margin: screenshot.imageBorder ? padding() : null,
            decoration: BoxDecoration(
              borderRadius: borderRadius(radius: 15.0),
              border: screenshot.imageBorder
                  ? Border.all(color: Colors.white, width: 2.0)
                  : null,
            ),
            child: const TakeScreenshot(
              child: ImageItem(
                imagePath: Paths.profileImage,
                label: "Favorite image",
              ),
            ),
          ),
          const ImageItem(
            imagePath: Paths.mapImage,
            label: "Map Image",
          ),
          SizedBox(
            height: context.screenHeight * .17,
          )
        ],
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem({
    super.key,
    required this.imagePath,
    required this.label,
  });

  final String label;
  final String imagePath;

  bool get isSvg => imagePath.endsWith(".svg");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            context.gapW2,
            Text(
              label,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.mainFont,
              ),
            ),
          ],
        ),
        context.gapH1,
        SizedBox(
          width: context.screenWidth * .9,
          child: ClipRRect(
            borderRadius: borderRadius(radius: 15.0),
            child: isSvg
                ? SvgPicture.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: context.screenHeight * .3,
                  )
                : Image.asset(imagePath),
          ),
        ),
      ],
    );
  }
}

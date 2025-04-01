import 'package:flutter/material.dart';
import 'package:screenshotapp/presentation_layer/screens/dialog_widget.dart';
import 'package:screenshotapp/presentation_layer/screens/image_widget.dart';
import 'package:screenshotapp/presentation_layer/screens/screen_widget.dart';
import 'package:screenshotapp/presentation_layer/screens/scroll_widget.dart';

class TapModel {
  final String title;
  final IconData icon;
  final Widget targetWidget;

  const TapModel({
    required this.icon,
    required this.title,
    required this.targetWidget,
  });
}

List<TapModel> taps = const <TapModel>[
  TapModel(
    icon: Icons.screenshot,
    title: "Full Screen",
    targetWidget: ScreenWidget(),
  ),
  TapModel(
    icon: Icons.image,
    title: "Full Image",
    targetWidget: ImageWidget(),
  ),
  TapModel(
    icon: Icons.widgets,
    title: "Full Dialog",
    targetWidget: DialogButton(),
  ),
  TapModel(
    icon: Icons.splitscreen_rounded,
    title: "Full Scroll",
    targetWidget: ScrollWidget(),
  ),
];

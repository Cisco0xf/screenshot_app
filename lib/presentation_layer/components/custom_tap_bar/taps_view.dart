import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/presentation_layer/components/custom_tap_bar/model.dart';
import 'package:screenshotapp/state_management_layer/pages_provider/select_screen_provider.dart';

class CustomTapBar extends StatelessWidget {
  const CustomTapBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.screenHeight * .12,
      right: 0.0,
      left: 0.0,
      child: Consumer<SelectTargetProvider>(
        builder: (context, targetScreen, _) {
          return SizedBox(
            height: context.screenHeight * .09,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: taps.length,
              itemBuilder: (context, index) {
                return TapBarItem(
                  isSelected: targetScreen.currentTarget == index,
                  onSelect: () {
                    targetScreen.changeScreen(target: index);
                  },
                  tap: taps[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class TapBarItem extends StatelessWidget {
  const TapBarItem({
    super.key,
    required this.isSelected,
    required this.onSelect,
    required this.tap,
  });

  final void Function() onSelect;
  final TapModel tap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: padding(),
      decoration: BoxDecoration(
        border: isSelected ? Border.all(color: Colors.white, width: 1.0) : null,
        color: isSelected ? AppColors.secondaryColor : AppColors.primaryColor,
        borderRadius: borderRadius(),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius(),
          onTap: onSelect,
          child: Padding(
            padding: padding(),
            child: Row(
              children: <Widget>[
                Icon(tap.icon),
                Text(tap.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

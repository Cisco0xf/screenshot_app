import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/commons/gaps.dart';
import 'package:screenshotapp/commons/navigator_key.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:screenshotapp/presentation_layer/screens/about_me.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_settings.dart';

Future<void> get showSettinsDialog async {
  final BuildContext context = navigatorKey.currentContext as BuildContext;
  await showDialog(
    context: context,
    builder: (context) {
      return Consumer<SettingsProvider>(
        builder: (context, controllers, _) {
          return Dialog(
            shape: roundedBorder(),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: padding(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    "Controllers",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  context.gapH1,
                  SettingItem(
                    icon: Icons.data_saver_on_outlined,
                    label: "Auto Save",
                    onSwitch: (autoSaver) {
                      controllers.changeAutoSaveState(
                        target: autoSaver,
                      );
                    },
                    setValue: controllers.autoSave,
                  ),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  SettingItem(
                    icon: Icons.timer,
                    label: "Show Counter",
                    onSwitch: (showCounter) {
                      controllers.changeCounterState(
                        target: showCounter,
                      );
                    },
                    setValue: controllers.showCounter,
                  ),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  const CuptureMethodWidget(),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius(radius: 15.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: borderRadius(radius: 15.0),
                        onTap: () {
                          Navigator.pop(context); // Pop the Settings Dialog
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const AboutMe();
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: padding(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: padding(),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.flutter,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "About Dev",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.mainFont,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onSwitch,
    required this.setValue,
  });

  final String label;
  final void Function(bool) onSwitch;
  final bool setValue;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon),
            context.gapW2,
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Switch(
          value: setValue,
          onChanged: onSwitch,
        ),
      ],
    );
  }
}

class CuptureMethodWidget extends StatelessWidget {
  const CuptureMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "Cupture method",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        context.gapH2,
        Consumer<SettingsProvider>(
          builder: (context, settings, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MethodItem(
                  isSelected: !settings.withDoubleTaps,
                  label: "Cupture Button",
                  onSelect: () {
                    settings.selectCuptureMethod(
                      target: false,
                    );
                  },
                ),
                MethodItem(
                  isSelected: settings.withDoubleTaps,
                  label: "Double Taps",
                  onSelect: () {
                    settings.selectCuptureMethod(
                      target: true,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class MethodItem extends StatelessWidget {
  const MethodItem({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onSelect,
  });

  final bool isSelected;
  final String label;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: context.screenWidth * .37,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRadius(),
        color: isSelected ? AppColors.secondaryColor : AppColors.primaryColor,
        border: Border.all(
          color: isSelected ? Colors.white : const Color(0xFF000000),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onSelect,
          borderRadius: borderRadius(),
          child: Padding(
            padding: padding(),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

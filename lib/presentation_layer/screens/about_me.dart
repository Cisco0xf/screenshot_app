import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:screenshotapp/commons/commons.dart';
import 'package:screenshotapp/commons/gaps.dart';
import 'package:screenshotapp/commons/navigator_key.dart';
import 'package:screenshotapp/commons/toastification.dart';
import 'package:screenshotapp/constants/app_dimensions.dart';
import 'package:screenshotapp/constants/colors.dart';
import 'package:screenshotapp/constants/texts.dart';
import 'package:screenshotapp/constants/fonts.dart';
import 'package:screenshotapp/constants/pathes.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(),
          MeBody(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _CustomSliverDelegate(
        targetBuild: Stack(
          children: <Widget>[
            Positioned.fill(
              bottom: 55,
              child: Container(
                height: context.screenHeight * .16,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryColor,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Mahmoud N. Al-sheyby",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMainColor,
                    fontFamily: FontFamily.subFont,
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xFFFFFFFF),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(Paths.profileImage),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget targetBuild;

  final BuildContext context = navigatorKey.currentContext as BuildContext;

  _CustomSliverDelegate({required this.targetBuild});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return targetBuild;
  }

  @override
  double get maxExtent => context.screenHeight * .32;

  @override
  double get minExtent => context.screenHeight * .27;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    bool shouldRebuild = minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent;

    return shouldRebuild;
  }
}

class MeBody extends StatelessWidget {
  const MeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          const BlaBlaWidget(
            title: aboutTitle,
            content: aboutContent,
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          const BlaBlaWidget(
            title: contactTitle,
            content: contactContent,
          ),
          const Divider(),
          const MyPlatFormsWidget(),
          const ProjectSrcCode(),
        ],
      ),
    );
  }
}

class BlaBlaWidget extends StatelessWidget {
  const BlaBlaWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            context.gapW2,
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.subFont,
                color: AppColors.textMainColor,
                fontSize: 22,
              ),
            ),
          ],
        ),
        context.gapH1,
        Padding(
          padding: padding(),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 19,
              fontFamily: FontFamily.subFont,
            ),
          ),
        ),
      ],
    );
  }
}

// Contact

class MyPlatFormsWidget extends StatelessWidget {
  const MyPlatFormsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            context.gapW2,
            const Text(
              getInTouch,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textMainColor,
                fontFamily: FontFamily.subFont,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            PlatFormWidget(
              toMe: () async {
                await LaunchUrl.luanchTargetUrl(
                  target: Paths.gitHub,
                );
              },
              icon: FontAwesomeIcons.github,
              platform: "Gihub",
            ),
            PlatFormWidget(
              toMe: () async {
                await LaunchUrl.luanchTargetUrl(
                  target: Paths.stackOverflow,
                );
              },
              icon: FontAwesomeIcons.stackOverflow,
              platform: "Stack Overflow",
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            PlatFormWidget(
              toMe: () async {
                await LaunchUrl.luanchTargetUrl(
                  target: Paths.linkedIn,
                );
              },
              icon: FontAwesomeIcons.linkedin,
              platform: "LinkedIn",
            ),
            PlatFormWidget(
              toMe: () async {
                final Uri email = Uri(
                  path: Paths.email,
                  scheme: "mailto",
                );

                bool canLaunch = await canLaunchUrl(email);
                if (!canLaunch) {
                  showToastification(
                    msg: "Could not launch the current url",
                    type: ToastificationType.error,
                  );
                  return;
                }

                await launchUrl(
                  email,
                  mode: LaunchMode.externalApplication,
                );
              },
              icon: FontAwesomeIcons.mailchimp,
              platform: "Email",
            ),
          ],
        ),
      ],
    );
  }
}

class PlatFormWidget extends StatelessWidget {
  const PlatFormWidget({
    super.key,
    required this.toMe,
    required this.icon,
    required this.platform,
  });

  final IconData icon;
  final String platform;
  final void Function() toMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding(),
      width: context.screenWidth * .4,
      decoration: BoxDecoration(
        borderRadius: borderRadius(radius: 15.0),
        color: AppColors.backgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: toMe,
          borderRadius: borderRadius(radius: 15.0),
          child: Padding(
            padding: padding(padding: 20),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  child: FaIcon(
                    icon,
                    size: 40,
                  ),
                ),
                context.gapH1,
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    platform,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectSrcCode extends StatelessWidget {
  const ProjectSrcCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1.6,
        ),
        borderRadius: borderRadius(radius: 5.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await LaunchUrl.luanchTargetUrl(
              target: Paths.srcCodePath,
            );
          },
          child: Padding(
            padding: padding(),
            child: Row(
              children: <Widget>[
                const FaIcon(FontAwesomeIcons.github, size: 40),
                SizedBox(
                  height: context.screenHeight * .07,
                  child: const VerticalDivider(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const FaIcon(FontAwesomeIcons.link, size: 15),
                        context.gapW2,
                        const Text(
                          "Source Code",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Access the project full source code  ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LaunchUrl {
  static Future<void> luanchTargetUrl({required String target}) async {
    final Uri uri = Uri.parse(target);
    bool canLaunch = await canLaunchUrl(uri);
    if (!canLaunch) {
      showToastification(
          msg: "Could not launch the current url",
          type: ToastificationType.error);
      return;
    }
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}

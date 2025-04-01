import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';

import 'package:screenshot/screenshot.dart';
import 'package:screenshotapp/commons/navigator_key.dart';
import 'package:screenshotapp/commons/toastification.dart';
import 'package:screenshotapp/state_management_layer/pages_provider/select_screen_provider.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/play_audoi.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_settings.dart';


class ManageScreenshot with ChangeNotifier {
  // Controller for each target widget
  static final ScreenshotController _fullScreenContrller =
      ScreenshotController();
  static final ScreenshotController scrollController = ScreenshotController();
  static final ScreenshotController _imageController = ScreenshotController();
  static final ScreenshotController _dialogController =
      ScreenshotController();

  // Get the current shown screen from the SelectTargetProvider

  static final BuildContext context =
      navigatorKey.currentContext as BuildContext;

  static SelectTargetProvider get _target => Provider.of<SelectTargetProvider>(
        context,
        listen: false,
      );

  // Access Settings Properties

  SettingsProvider get settings => Provider.of<SettingsProvider>(
        context,
        listen: false,
      );

  // Set the controller according to the current screen

  static ScreenshotController get screenShotController {
    switch (_target.currentTarget) {
      case 0:
        {
          return _fullScreenContrller;
        }
      case 1:
        {
          return _imageController;
        }
      case 2:
        {
          return _dialogController;
        }
      case 3:
        {
          return scrollController;
        }
      default:
        {
          return _fullScreenContrller;
        }
    }
  }

  // Request the Storage permission and check if it is granted

  Future<bool> get requestStoragePermission async {
    final PermissionStatus permission = await Permission.storage.request();

    if (permission.isGranted) {
      return true;
    }

    if (permission.isDenied) {
      await Permission.storage.request();
      return false;
    }

    return false;
  }

  /// Create bools for each screenShot to trigger the border Status

  bool fullBorder = false;
  bool imageBorder = false;
  bool dialogBorder = false;
  bool scrollBorder = false;

  void get changeBorderState {
    final int currentTarget = _target.currentTarget;

    if (currentTarget == 0) {
      fullBorder = !fullBorder;
    } else if (currentTarget == 1) {
      imageBorder = !imageBorder;
    } else if (currentTarget == 2) {
      dialogBorder = !dialogBorder;
    } else if (currentTarget == 3) {
      scrollBorder = !scrollBorder;
    }

    notifyListeners();
  }

  /// Create count down method
  int countDown = 5;

  // To Control the visibility of the CountDown Text
  bool showCountDown = false;

  bool animateText = false;

  // Record to get the text properties that used for animation
  (double size, double opacity) get textProperties {
    double size = animateText ? 70 : 100;
    double opcaty = animateText ? 0.6 : 1.0;

    return (size, opcaty);
  }

  Future<void> get startShot async {
    showCountDown = true;
    notifyListeners();
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer counter) async {
        if (countDown > 1) {
          // Animate the Counter Text due to the trigger
          if (countDown % 2 != 0) {
            animateText = true;
          } else {
            animateText = false;
          }

          // Count down the Counter
          countDown--;
        } else {
          counter.cancel();

          // Hide Counter before take the screenshot
          showCountDown = false;

          // Take screenshote after clean screen
          await cuptureScreenshot;

          // Reset Counter
          countDown = 5;
        }

        notifyListeners();
      },
    );
  }

  // bool to show the Image layer After shot

  bool showScreenshotImg = false;

  void get showImage {
    showScreenshotImg = true;
    notifyListeners();
  }

  void get hideImage {
    showScreenshotImg = false;
    notifyListeners();
  }

  Uint8List? shownScreenshot;

  Future<void> get cuptureScreenshot async {
    try {
      bool isPermissionGranted = await requestStoragePermission;
      if (!isPermissionGranted) {
        showToastification(
          msg: "Screenshot needs Storage permissiont to save image.",
          title: "Permission denied",
        );

        log("Permission is not granted !!");

        return;
      }

      changeBorderState;

      log("Start Cupturing...");

      final Uint8List? screenshot = await screenShotController.capture();

      shownScreenshot = screenshot;

      notifyListeners();

      changeBorderState;

      await PlayAudio.play;

      // log("Image : $screenshot");

      log("Image Cuptured ...");

      if (!settings.autoSave) {
        showImage;

        return;
      }

      await saveImageToGallery;
    } catch (error) {
      log("Error while taking screenShot : $error");

      showToastification(
        msg: error.toString(),
        title: "Error !!",
        type: ToastificationType.error,
      );
    }
  }

  // Save Screenshot to gallery

  Future<void> get saveImageToGallery async {
    if (shownScreenshot != null) {
      final String imageName = "ScreenShot_${DateTime.now()}";
      final SaveResult image = await SaverGallery.saveImage(
        shownScreenshot!,
        fileName: imageName,
        skipIfExists: false,
      );

      showToastification(
        msg: "Screenshot Saved to gallery successfully.",
        title: "Saved to Gallery",
        type: ToastificationType.success,
      );

      log("Is Image Saved : ${image.isSuccess}");
      log("Image Error : ${image.errorMessage}");
    }
  }

  // Save Screenshot then enable sharing it

  Future<void> get shareAndSave async {
    hideImage;

    await saveImageToGallery;

    final Directory dir = await getTemporaryDirectory();

    final File image = File('${dir.path}/screenshot.png');

    final File targetImg = await image.writeAsBytes(
      shownScreenshot as Uint8List,
    );

    final String tempPath = targetImg.path;

    final XFile xFile = XFile(tempPath);

    await Share.shareXFiles(<XFile>[xFile]);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  // Auto Save
  bool autoSave = false;

  void changeAutoSaveState({required bool target}) {
    autoSave = target;
    log("Current Auto Save : $autoSave");
    notifyListeners();
  }

  // Show Counter

  bool showCounter = true;

  void changeCounterState({required bool target}) {
    showCounter = target;

    log("Current Show Counter : $showCounter");

    notifyListeners();
  }

  // Create mute Mode

  bool isMute = false;

  void setSoundValue({
    required bool target,
  }) {
    isMute = target;
    notifyListeners();
  }

  // Take screenshot method

  bool withDoubleTaps = false;

  void selectCuptureMethod({
    required bool target,
  }) {
    withDoubleTaps = target;

    log("Is Current Method Double Taps :$withDoubleTaps");

    notifyListeners();
  }
}

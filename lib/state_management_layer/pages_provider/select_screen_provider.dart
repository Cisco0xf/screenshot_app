import 'package:flutter/material.dart';

// Select the current Target for screenshot

class SelectTargetProvider with ChangeNotifier {
  int currentTarget = 0;

  void changeScreen({
    required int target,
  }) {
    currentTarget = target;
    notifyListeners();
  }

  bool get isDialog => currentTarget == 2;
}

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  bool iconVal = true;

  setLoading(bool newVal) {
    isLoading = newVal;
    notifyListeners();
  }

  setIconValue(bool newVal) {
    iconVal = newVal;
    notifyListeners();
  }
}

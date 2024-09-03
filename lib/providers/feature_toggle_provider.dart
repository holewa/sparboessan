import 'package:flutter/material.dart';

class FeatureToggleProvider extends ChangeNotifier {
  final Map<String, bool> _toggles = {};

  bool isFeatureToggled(String featureKey) {
    return _toggles[featureKey] ?? false;
  }

  void setFeatureToggled(String featureKey, bool isToggled) {
    _toggles[featureKey] = isToggled;
    notifyListeners();
  }
}

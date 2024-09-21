// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class FeatureToggleProvider extends ChangeNotifier {
//   Map<String, bool> _featureToggles = {};
//
//   // Load feature toggles for the currently logged-in user
//   Future<void> loadFeatureToggles(String username) async {
//     final prefs = await SharedPreferences.getInstance();
//     print(prefs.getBool('$username-darkMode'));
//     _featureToggles = {
//       'darkMode': prefs.getBool('$username-darkMode') ?? false,
//       'someFeature': prefs.getBool('$username-someFeature') ?? false,
//     };
//     notifyListeners();
//   }
//
// // Set feature toggle and store it for the given username
//   Future<void> setFeatureToggled(
//       String username, String featureKey, bool value) async {
//     _featureToggles[featureKey] = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('$username-$featureKey', value);
//     notifyListeners();
//   }
//
//   // Check if a feature is toggled for the current user
//   bool isFeatureToggled(String featureKey) {
//     return _featureToggles[featureKey] ?? false;
//   }
//
//   // Reset feature toggles on logout
//   void resetFeatureToggles() {
//     _featureToggles.clear();
//     notifyListeners();
//   }
// }

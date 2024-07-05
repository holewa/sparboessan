import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _currentUser = 'user has not been registered';
  bool _isLoggedIn = false;

  String get name => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  void setName(String newName) {
    _currentUser = newName;
    notifyListeners();
  }

  void setIsLoggedIn() {
    _isLoggedIn = true;
    notifyListeners();
  }
}

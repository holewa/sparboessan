import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _currentUser = 'Ruben';
  bool _isLoggedIn = false;

  String get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  void setName(String newName) {
    _currentUser = newName;
    notifyListeners();
  }

  void setIsLoggedIn() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void setIsLoggedOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

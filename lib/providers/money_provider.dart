import 'dart:async';

import 'package:flutter/material.dart';

class MoneyProvider extends ChangeNotifier {
  int _currentMoney = 0;
  int _currentLevel = 1;
  final int _maxLevel = 3;
  Timer? _timer;

  MoneyProvider() {
    _startTimer();
  }

  int get currentMoney => _currentMoney;
  String get currentMoneyText => '$_currentMoney kr';
  int get currentLevel => _currentLevel;
  int get maxLevel => _maxLevel;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      incrementMoney();
    });
  }

  void incrementMoney() {
    _currentMoney += _currentLevel * 10;
    if (_currentLevel != _maxLevel) {
      _currentLevel++;
    }
    notifyListeners();
  }

  void updateMoney(int newAmount) {
    _currentMoney += newAmount;
    notifyListeners();
  }

  void useYourMoney() {
    _currentMoney = 0;
    _currentLevel = 1;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

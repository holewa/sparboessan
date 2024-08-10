import 'package:flutter/material.dart';

class MoneyProvider extends ChangeNotifier {
  int _currentMoney = 0;
  int _currentLevel = 1;
  final int _maxLevel = 3;
  int _moneyToGetThisWeek = 10;

  int get currentMoney => _currentMoney;
  String get currentMoneyText => '$_currentMoney kr';
  int get currentLevel => _currentLevel;
  int get maxLevel => _maxLevel;
  int get moneyGottenThisWeek => _moneyToGetThisWeek;

  void incrementMoney() {
    _moneyToGetThisWeek = _currentLevel * 10;
    _currentMoney += _moneyToGetThisWeek;
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
}

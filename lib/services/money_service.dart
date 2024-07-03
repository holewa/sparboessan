class MoneyService {
final int _maxLevel = 3;
int _currentMoney = 0;
int _currentLevel = 1;

  int get currentMoney => _currentMoney;

  int get currentLevel => _currentLevel;

  void useYourMoney() {
    _currentMoney = 0;
    _currentLevel = 1;
  }

  void incrementMoneyLevel() {
      _currentMoney += _currentLevel * 10;
      if (_currentLevel != _maxLevel) {
        _currentLevel++;
      }
  }
}

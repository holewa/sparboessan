import 'package:flutter/material.dart';
import 'package:pengastigen/models/user.dart';
import 'package:pengastigen/providers/money_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  Map<String, User> _users = {};
  User? _currentUser;

  final List<String> users = ['Ruben', 'Otto', 'Admin'];

  final List<String> _superUsers = ['Admin'];

  User? get currentUser => _currentUser;

  String get username => _currentUser?.username ?? '';

  bool get isLoggedIn => _currentUser != null;

  int get currentUserMoney => _currentUser?.currentMoney ?? 0;

  bool get isSuperUser =>
      _currentUser != null && _superUsers.contains(_currentUser!.username);

  final MoneyService _moneyService;

  UserProvider(this._moneyService) {
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (String key in keys) {
      final userJson = prefs.getString(key);
      if (userJson != null) {
        final user = User.fromJson(userJson);
        _users[user.username] = user;
      }
    }
    notifyListeners();
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(user.username, user.toJson());
  }

  Future<bool> logIn(String username) async {
    if (users.contains(username)) {
      if (!_users.containsKey(username)) {
        final user = User(username: username);
        _users[username] = user;
        await _saveUser(user);
      }
      _currentUser = _users[username];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logOut() async {
    _currentUser = null;
    notifyListeners();
  }

  Future<void> incrementMoneyForAllUsers() async {
    _users.forEach((username, user) => (_moneyService.incrementMoney(user)));
    notifyListeners();
  }

  Future<void> useMoney() async {
    if (_currentUser != null) {
      _moneyService.useMoney(_currentUser!);
      await _saveUser(_currentUser!);
      notifyListeners();
    }
  }

  void updateUserMoney(String username, int amount) {
    if (isSuperUser) {
      final user = _users[username];
      if (user != null) {
        user.addMoney(amount);
        notifyListeners();
        print('money added');
      }
    } else {
      throw Exception('Unauthorized action');
    }
  }
}

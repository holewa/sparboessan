import 'package:flutter/material.dart';
import 'package:pengastigen/models/user.dart';
import 'package:pengastigen/providers/money_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final Map<String, User> _users = {};
  User? _user;
  String _selectedUser = '';
  final List<String> usersNames = ['Ruben', 'Otto', 'Admin'];
  final List<String> _superUsers = ['Admin'];
  final MoneyService _moneyService;

  //etters
  User? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get isSuperUser =>
      _user != null && _superUsers.contains(_user!.username);
  String get selectedUser => _selectedUser;
  Map<String, bool>? get featureToggles => user?.featureToggles;
  Map<String, User>? get users => _users;

  // String get username => _user?.username ?? '';
  // int get currentMoney => _user?.currentMoney ?? 0;
  // String? get avatar => user?.avatar;


  UserProvider(this._moneyService) {
    _loadUsers();
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(user.username, user.toJson());
  }

  Future<bool> logIn(String username) async {
    if (usersNames.contains(username)) {
      if (!_users.containsKey(username)) {
        final user = User(username: username);
        _users[username] = user;
        await _saveUser(user);
      }
      _user = _users[username];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logOut() async {
    _user = null;
    notifyListeners();
  }

  Future<void> incrementMoneyForAllUsers() async {
    _users.forEach((username, user) => (_moneyService.incrementMoney(user)));
    notifyListeners();
  }

  Future<void> useMoney() async {
    if (_user != null) {
      _moneyService.useMoney(_user!);
      await _saveUser(_user!);
      notifyListeners();
    }
  }

  void updateUserMoney(String username, int amount) {
    if (isSuperUser) {
      final user = _users[username];
      if (user != null) {
        user.addMoney(amount);
        notifyListeners();
      }
    } else {
      throw Exception('Unauthorized action');
    }
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

  bool isFeatureToggled(String featureKey) {
    if (featureToggles != null && featureToggles!.containsKey(featureKey)) {
      return featureToggles?[featureKey] ?? false;
    }
    return false;
  }

  void setFeatureToggle(String featureKey) {
    featureToggles![featureKey] = !(featureToggles![featureKey] ?? false);
    notifyListeners();
  }

  void setSelectedUser(String user) {
    _selectedUser = user;
    notifyListeners();
  }

  void setAvatar(String avatar) {
    user?.avatar = avatar;
    notifyListeners();
  }

}

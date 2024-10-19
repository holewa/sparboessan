import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pengastigen/models/user.dart';
import 'package:pengastigen/service/money_service.dart';
import 'package:pengastigen/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final Map<String, User> _users = {};
  User? _user;
  String _selectedUser = '';
  final MoneyService _moneyService;
  final UserService _userService;

  //getters
  User? get user => _user;
  bool get isLoggedIn => _user != null;
  // bool get isSuperUser => _user != null && _superUsers.contains(_user!.username);
  String get selectedUser => _selectedUser;
  Map<String, bool>? get featureToggles => user?.featureToggles;
  Map<String, User>? get users => _users;

  String apiUrl = 'http://localhost:8080';

  // String get username => _user?.username ?? '';
  // int get currentMoney => _user?.currentMoney ?? 0;
  // String? get avatar => user?.avatar;

  UserProvider(this._moneyService, this._userService);

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(user.username, user.toJson());
  }

  Future<bool> logIn(String username, int id) async {
    if (!_users.containsKey(username)) {
      final user = User(username: username, id: id);
      _users[username] = user;
      await _saveUser(user);
    }
    _user = _users[username];
    notifyListeners();
    return true;
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
    // if (isSuperUser) {
    final user = _users[username];
    if (user != null) {
      user.addMoney(amount);
      notifyListeners();
    }
    // } else {
    //   throw Exception('Unauthorized action');
    // }
  }

  List<User> parsedUsers(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<void> loadUsers() async {
    var response = await _userService.fetchUsers();

    if (response.statusCode == 200) {
      List<User> users = parsedUsers(response.body);
      for (var val in users) {
        _users[val.username] = val;
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

  void setSelectedUser(String user) async {
    _selectedUser = user;
    notifyListeners();
  }

  Future<void> setAvatar(String avatar) async {
    user?.avatar = avatar;
    notifyListeners();
  }
}

import 'dart:convert';

class User {
  String username;
  int currentMoney;
  int currentLevel;
  int moneyToGetThisWeek;
  final int maxLevel;

  User({
    required this.username,
    this.currentMoney = 0,
    this.currentLevel = 1,
    this.maxLevel = 3,
    this.moneyToGetThisWeek = 10,
  });

  // Create a User instance from a Map (used in fromJson)
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      username: data['username'],
      currentMoney: data['currentMoney'],
      currentLevel: data['currentLevel'],
      maxLevel: data['maxLevel'],
      moneyToGetThisWeek: data['moneyToGetThisWeek'],
    );
  }

  // Convert a User instance to a Map (used in toJson)
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'currentMoney': currentMoney,
      'currentLevel': currentLevel,
      'maxLevel': maxLevel,
      'moneyToGetThisWeek': moneyToGetThisWeek,
    };
  }

  // For saving to SharedPreferences
  String toJson() => jsonEncode(toMap());

  // For loading from SharedPreferences
  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));


  void incrementMoney() {
    const int maxLevel = 3;
    moneyToGetThisWeek = currentLevel * 10;
    currentMoney += moneyToGetThisWeek;
    if (currentLevel != maxLevel) {
      currentLevel++;
    }
  }

  //används inte än 
  void addMoney(int newAmount) {
    currentMoney += newAmount;
  }

  void useMoney() {
    currentMoney = 0;
    currentLevel = 1;
  }
}

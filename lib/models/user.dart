import 'dart:convert';

class User {
  int id;
  String username;
  int currentMoney;
  int currentLevel;
  int moneyToGetThisWeek;
  final int maxLevel;
  Map<String, bool> featureToggles;
  String avatar;

  User({required this.id,
      required this.username,
      this.currentMoney = 0,
      this.currentLevel = 1,
      this.maxLevel = 3,
      this.moneyToGetThisWeek = 10,
      this.featureToggles = const {},
      this.avatar = 'standard'});

  // Create a User instance from a Map (used in fromJson)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] ?? '',
      currentMoney: json['currentMoney'] ?? 0,
      currentLevel: json['currentLevel'] ?? 1,
      maxLevel: json['maxLevel'] ?? 3,
      moneyToGetThisWeek: json['moneyToGetThisWeek'] ?? 10,
      featureToggles: Map<String, bool>.from(json['featureToggles'] ?? {}),
      avatar: json['avatar'] ?? 'standard',
    );
  }
  // Convert a User instance to a Map (used in toJson)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'currentMoney': currentMoney,
      'currentLevel': currentLevel,
      'maxLevel': maxLevel,
      'moneyToGetThisWeek': moneyToGetThisWeek,
      'featureToggles': featureToggles,
      'avatar': avatar,
    };
  }

  // For saving to SharedPreferences
  String toJson() => jsonEncode(toMap());

  // For loading from SharedPreferences
  // factory User.fromJson(String json) => User.fromMap(jsonDecode(json));

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

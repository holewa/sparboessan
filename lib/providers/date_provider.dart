import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';

class DateProvider extends ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  final UserProvider userProvider;

  //kan raderas sen
  int day = 1;
  late DateTime _currentTimeFake = DateTime.utc(2024, 7, day);

  Timer? _timer;

  DateProvider(this.userProvider) {
    _startTimerFake();
  }

  String get currentDay => getDayOfTheWeek(_currentTimeFake);

  String get daysUntilSaturdayText =>
      _daysUntilSaturdayText(_daysUntilSaturdayFake());

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      updateTime();
    });
  }

  //2 fake methods for easier day handling
  void _startTimerFake() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      updateTimeFakeDays();
    });
  }

  void updateTimeFakeDays() {
    if (getDayOfTheWeek(_currentTimeFake) == "Fredag") {
        userProvider.incrementMoneyForAllUsers();
      } 
    if (day == 8) {
      day = 1;
    }
    day++;
    _currentTimeFake = DateTime.utc(2024, 7, day);
    notifyListeners();
  }

  int _daysUntilSaturdayFake() {
    int saturday = DateTime.saturday;
    int daysUntilSaturday = saturday - day;
    return daysUntilSaturday;
  }

  void updateTime() {
    _currentTime = DateTime.now();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _daysUntilSaturdayText(daysUntilSaturday) {
    if (daysUntilSaturday == 1) {
      return '$daysUntilSaturday dag kvar till veckopeng';
    }
    if (daysUntilSaturday > 0) {
      return '$daysUntilSaturday dagar kvar till veckopeng';
    }
    //händer på söndag och måndag
    if (daysUntilSaturday < 0) {
      int totalDays = daysUntilSaturday + 7;
      return '$totalDays dagar kvar till veckopeng!';
    }

    //händer bara på lördagar
    return 'Idag har du fått ${userProvider.currentUser?.moneyToGetThisWeek} kr i veckopeng!';
  }
}

String getDayOfTheWeek(DateTime dateTime) {
  final DateFormat dateFormat = DateFormat('EEEE', 'sv_SE');
  return dayToUpperString(dateFormat.format(dateTime));
}

String dayToUpperString(String day) {
  return day.substring(0, 1).toUpperCase() + day.substring(1);
}

int _daysUntilSaturday() {
  int saturday = DateTime.saturday;
  int daysUntilSaturday = saturday - DateTime.now().day;
  return daysUntilSaturday;
}

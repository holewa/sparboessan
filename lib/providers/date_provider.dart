import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pengastigen/constans/feature_toggles.dart';
import 'package:pengastigen/providers/user_provider.dart';

class DateProvider extends ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  final UserProvider userProvider;

  Timer? _timer;

  DateProvider(this.userProvider) {
    bool isTestEnviroment =
        userProvider.isFeatureToggled(FeatureToggles.testEnviroment);

    isTestEnviroment ? _startTimerFake() : _startTimer();
  }

  String get currentDay => userProvider.isFeatureToggled(FeatureToggles.testEnviroment) 
      ? getDayOfTheWeek(_currentTimeFake)
      : getDayOfTheWeek(_currentTime);

  String get daysUntilSaturdayText => userProvider.isFeatureToggled(FeatureToggles.testEnviroment) 
      ? _daysUntilSaturdayText(_daysUntilSaturdayFake())
      : _daysUntilSaturdayText(_daysUntilSaturday());

  void _startTimer() {
    dispose();
    _timer = Timer.periodic(const Duration(hours: 23), (timer) {
      updateTime();
    });
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
    return 'Idag har du fått ${userProvider.user?.moneyToGetThisWeek} kr i veckopeng!';
  }

  String get currentFakeDay => getDayOfTheWeek(_currentTimeFake);

  //används bara i testsyfte
  int day = 1;
  late DateTime _currentTimeFake = DateTime.utc(2024, 7, day);

  //fake methods for easier day handling
  void _startTimerFake() {
    dispose();
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
  int daysUntilSaturday = saturday - DateTime.now().weekday;
  return daysUntilSaturday;
}

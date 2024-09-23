import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pengastigen/constans/feature_toggles.dart';
import 'package:pengastigen/providers/user_provider.dart';

class DateProvider extends ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  final UserProvider userProvider;
  Timer? _timer;
  int day = 1; // For testing mode
  DateTime _currentTimeFake = DateTime.utc(2024, 7, 1); // Start in test mode

  DateProvider(this.userProvider) {
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    Duration timerDuration =
        userProvider.isFeatureToggled(FeatureToggles.testEnviroment)
            ? const Duration(seconds: 4)
            : const Duration(hours: 23);

    _timer = Timer.periodic(timerDuration, (timer) {
      if (userProvider.isFeatureToggled(FeatureToggles.testEnviroment)) {
        updateTimeFakeDays();
      } else {
        updateTime();
      }
    });
  }

  void toggleEnvironment() {
    // Call this method to switch environments
    _startTimer(); // Restart timer with the new settings
    notifyListeners(); // Notify listeners of the change
  }

  void updateTime() {
    _currentTime = DateTime.now();
    notifyListeners();
  }

  void updateTimeFakeDays() {
    if (getDayOfTheWeek(_currentTimeFake) == "Fredag") {
      userProvider.incrementMoneyForAllUsers();
    }
    if (day == 8) day = 1;
    day++;
    _currentTimeFake = DateTime.utc(2024, 7, day);
    notifyListeners();
  }

  String get currentDay => getDayOfTheWeek(
      userProvider.isFeatureToggled(FeatureToggles.testEnviroment)
          ? _currentTimeFake
          : _currentTime);

  String get daysUntilSaturdayText => _daysUntilSaturdayText(
      userProvider.isFeatureToggled(FeatureToggles.testEnviroment)
          ? _daysUntilSaturdayFake()
          : _daysUntilSaturday());


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

  int _daysUntilSaturday() => DateTime.saturday - DateTime.now().weekday;
  int _daysUntilSaturdayFake() => DateTime.saturday - day;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

String getDayOfTheWeek(DateTime dateTime) {
  final DateFormat dateFormat = DateFormat('EEEE', 'sv_SE');
  return dayToUpperString(dateFormat.format(dateTime));
}

String dayToUpperString(String day) {
  return day.substring(0, 1).toUpperCase() + day.substring(1);
}

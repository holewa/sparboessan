import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';

class DateProvider extends ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  final UserProvider userProvider;
  Timer? _timer;

  DateProvider(this.userProvider) {
    _startTimer();
  }

  void _startTimer() {
    Duration timerDuration = const Duration(hours: 23);

    _timer = Timer.periodic(timerDuration, (timer) {
        updateTime();
    });
  }

  void updateTime() {
    _currentTime = DateTime.now();
    notifyListeners();
  }


  String get daysUntilSaturdayText => _daysUntilSaturdayText(_daysUntilSaturday());


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

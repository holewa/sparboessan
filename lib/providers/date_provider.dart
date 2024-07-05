import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  int _currentDay = DateTime.now().day;

  Timer? _timer;

  DateProvider() {
    _startTimer();
  }

  String get currentDay => getDayOfTheWeek(_currentTime);

  String get daysUntilSaturdayText =>
      _daysUntilSaturdayText(_daysUntilSaturday());

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

String _daysUntilSaturdayText(daysUntilSaturday) {
  if (daysUntilSaturday == 1) {
    return '$daysUntilSaturday dag kvar till veckopeng!';
  }
  if (daysUntilSaturday > 0) {
    return '$daysUntilSaturday dagar kvar till veckopeng!';
  }
  //borde bara hända på söndagar!
  if (daysUntilSaturday < 0) {
    return '6 dagar kvar till veckopeng!';
  }
  //borde bara hända på lördagar!
  return 'Idag har du fått x veckopeng!';
}

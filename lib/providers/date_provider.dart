import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  DateProvider() {
    _startTimer();
  }

  DateTime get currentTime => _currentTime;
  String get currentDay => getDayOfTheWeek(_currentTime);

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

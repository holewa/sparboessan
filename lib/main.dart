import 'dart:async';

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pengastigen/constans/app_colors.dart';
import 'package:pengastigen/constans/get_color_by_level.dart';
import 'package:pengastigen/services/date_service.dart';
import 'package:pengastigen/widgets/level_indicator.dart';
import 'package:pengastigen/widgets/develop/widget_wrapper.dart';

void main() {
  initializeDateFormatting();
  runApp(const SavingApp());
}

class SavingApp extends StatelessWidget {
  const SavingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MoneyTracker(),
    );
  }
}

class MoneyTracker extends StatefulWidget {
  const MoneyTracker({super.key});

  @override
  State<MoneyTracker> createState() => _MoneyTrackerState();
}

class MoneyTrackerContent extends StatelessWidget {
  final int currentMoney;
  final String dayOfTheWeek;
  final VoidCallback onUseYourMoney;
  final int level;

  const MoneyTrackerContent({
    required this.currentMoney,
    required this.dayOfTheWeek,
    required this.onUseYourMoney,
    required this.level,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final moneyText = '$currentMoney kr';

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        WidgetWrapper(
          child: AvatarGlow(
            startDelay: const Duration(milliseconds: 1000),
            glowColor: GetColorByLevel.getColorByLevel(level),
            glowShape: BoxShape.circle,
            curve: Curves.fastOutSlowIn,
            child: Material(
              elevation: 8.0,
              shape: const CircleBorder(),
              color: Colors.transparent,
              child: Text(
                moneyText,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ),
        WidgetWrapper(
            child: Visibility(
          visible: currentMoney != 0,
          child: ElevatedButton(
            onPressed: onUseYourMoney,
            child: const Text('Använd dina pengar!'),
          ),
        )),
        const SizedBox(height: 20),
        WidgetWrapper(
            child: Container(
          width: 100,
          decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.8), border: Border.all()),
          child: Text(dayOfTheWeek,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, //TODO dynamicly color
              )),
        )),
      ],
    );
  }
}

// String getDayOfTheWeek(DateTime dateTime) {
//   final DateFormat dateFormat = DateFormat('EEEE', 'sv_SE');
//   return dateFormat.format(dateTime);
// }

String dayToUpperString(String day) {
  return day.substring(0, 1).toUpperCase() + day.substring(1);
}

class _MoneyTrackerState extends State<MoneyTracker> {
  int _currentMoney = 0;
  int _level = 1;
  final int _maxLevel = 3;

  late DateTime now;
  late Timer timeTimer;
  late Timer pointsTimer;

  @override
  Widget build(BuildContext context) {
    DateTime dateNow = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sparbössan'),
        backgroundColor: AppColors.backgroundColorTheme,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/pig.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: MoneyTrackerContent(
                    currentMoney: _currentMoney,
                    dayOfTheWeek: DateService.getDayOfTheWeek(dateNow),
                    onUseYourMoney: _useYourMoney,
                    level: _level,
                  ),
                ),
              ),
              LevelIndicator(maxLevel: _maxLevel, level: _level),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timeTimer.cancel();
    pointsTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    timeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
    pointsTimer = Timer.periodic(
        const Duration(seconds: 10), (Timer t) => _incrementLevel());
  }

  void _incrementLevel() {
    setState(() {
      _currentMoney += _level * 10;
      if (_level != _maxLevel) {
        _level++;
      }
    });
  }

  void _updateTime() {
    setState(() {
      now = DateTime.now();
    });
  }

  void _useYourMoney() {
    setState(() {
      _level = 1;
      _currentMoney = 0;
    });
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pengastigen/constans/app_colors.dart';
import 'package:pengastigen/constans/get_color_by_level.dart';
import 'package:pengastigen/services/date_service.dart';
import 'package:pengastigen/services/money_service.dart';
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sparbössan'),
          backgroundColor: AppColors.backgroundColorTheme,
        ),
        body: Container(
          // margin: const EdgeInsets.all(20),
          // padding: const EdgeInsets.all(20),
          child: const MoneyTracker(),
        ),

        // WidgetWrapper(
        //     child: Container(
        //   width: 100,
        //   decoration: BoxDecoration(
        //       color: Colors.red.withOpacity(0.8), border: Border.all()),
        //   child: Text(dayOfTheWeek,
        //       textAlign: TextAlign.center,
        //       overflow: TextOverflow.ellipsis,
        //       style: const TextStyle(
        //         fontSize: 24,
        //         fontWeight: FontWeight.bold,
        //         color: AppColors.backgroundColorTheme, //TODO dynamicly color
        //       )),
        // )),
      ),
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
  final VoidCallback onUseYourMoney;
  final int level;


   const MoneyTrackerContent({
    required this.currentMoney,
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
        const SizedBox(height: 120),
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
      ],
    );
  }
}

class _MoneyTrackerState extends State<MoneyTracker> {
 final MoneyService _moneyService = MoneyService();

  late DateTime now;
  late Timer timeTimer;
  late Timer pointsTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    currentMoney: _moneyService.currentMoney,
                    onUseYourMoney: _useYourMoney,
                    level: _moneyService.currentLevel,
                  ),
                ),
              ),
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
    timeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
    pointsTimer = Timer.periodic(
        const Duration(seconds: 10), (Timer t) => _incrementMoneyLevel());
  }

  void _incrementMoneyLevel() {
    setState(() {
       _moneyService.incrementMoneyLevel();   
        });
  }
  

  void _updateTime() {
    setState(() {
      now = DateTime.now();
    });
  }

  void _useYourMoney() {
    setState(() {
      _moneyService.useYourMoney();
    });
  }
}

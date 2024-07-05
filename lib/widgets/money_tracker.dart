import 'package:flutter/material.dart';
import 'dart:async';

class MoneyTracker extends StatefulWidget {
  const MoneyTracker({super.key});

  @override
  State<MoneyTracker> createState() => _MoneyTrackerState();
}

class _MoneyTrackerState extends State<MoneyTracker> {
  int currentMoney = 0;
  int currentLevel = 1;
  int maxLevel = 3;
  late Timer timeTimer;
  late Timer pointsTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(
            'Money:  $currentMoney',
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey,
              fontFamily: 'IndieFlower',
            ),
          ),
        ],
    );
  }
  // return Scaffold(
  //   body: Stack(
  //     children: [
  //       // Background image
  //       Positioned.fill(
  //         child: Image.asset(
  //           'assets/images/pig.png',
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //     ],
  //   ),
  // );

}

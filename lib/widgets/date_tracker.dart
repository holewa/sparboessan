import 'package:flutter/material.dart';
import 'dart:async';

class DateTracker extends StatefulWidget {
  const DateTracker({super.key});

  @override
  State<DateTracker> createState() => _DateTrackerState();
}

class _DateTrackerState extends State<DateTracker> {
  late DateTime now;
  late Timer timeTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(
            'date:  $now',
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

  @override
  void dispose() {
    timeTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      now = DateTime.now();
    });
  }
}

import 'package:flutter/material.dart';

class GetColorByLevel {
  static getColorByLevel(int level) {
    switch (level) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}

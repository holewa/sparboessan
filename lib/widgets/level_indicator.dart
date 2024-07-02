import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pengastigen/constans/get_color_by_level.dart';

class LevelIndicator extends StatelessWidget {
  final int maxLevel;
  final int level;

  const LevelIndicator(
      {required this.maxLevel, required this.level, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(children: [
            FaIcon(FontAwesomeIcons.arrowTurnUp),
            Text(
              'Level:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          const SizedBox(
              height: 10), // Optional: Adds space between text and icons

          Row(
            children: List.generate(maxLevel, (index) {
              late bool isCurrentLevel = index + 1 == level;
              return Row(
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.star),
                    color: GetColorByLevel.getColorByLevel(index + 1),
                    iconSize: isCurrentLevel ? 40 : 20,
                    onPressed: () {},
                  ),
                  if (index < maxLevel - 1)
                    const Divider(
                      // Use VerticalDivider instead of Divider for vertical lines
                      height: 20, // Set width for the divider line
                      color: Colors.black,
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

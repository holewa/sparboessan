import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pengastigen/constans/get_color_by_level.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LevelIndicator extends StatelessWidget {
  final int maxLevel = 3;

  const LevelIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Level',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: List.generate(maxLevel, (index) {
                  bool isCurrentLevel =
                      index + 1 == context.watch<UserProvider>().currentUser?.currentLevel;
                  return Row(
                    children: [
                      IconButton(
                        tooltip:
                            'Nivå ${index + 1} - Denna nivå ger dig ${(index + 1) * 10} kr varje vecka!',
                        icon: const FaIcon(FontAwesomeIcons.star),
                        color: GetColorByLevel.getColorByLevel(index + 1),
                        iconSize: isCurrentLevel ? 40 : 20,
                        onPressed: () {},
                      ),
                      if (index < maxLevel - 1)
                        const VerticalDivider(
                          width: 20, // Set width for the divider line
                          color: Colors.black,
                        ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

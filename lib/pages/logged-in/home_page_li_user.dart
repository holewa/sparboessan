import 'package:flutter/material.dart';
import 'package:pengastigen/constans/feature_toggles.dart';
import 'package:pengastigen/providers/date_provider.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:pengastigen/widgets/level_indicator.dart';
import 'package:pengastigen/widgets/use_money_dialog.dart';
import 'package:provider/provider.dart';

class HomePageLoggedInUser extends StatelessWidget {
  const HomePageLoggedInUser({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final bool isTestEnvironment =
        userProvider.isFeatureToggled(FeatureToggles.testEnviroment);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensures the background image covers the whole screen
        children: [
          // Background image
          if (isTestEnvironment)
            const Image(
              image: NetworkImage(
                  "https://testsigma.com/blog/wp-content/uploads/blog-24_6bcd0d8524197c6dd9e305692ac92fc9_2000.jpg"),
              fit: BoxFit.cover,
            ),
          // The rest of the UI on top of the background image
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 417, top: 10),
                child: Text(
                  context.watch<DateProvider>().currentDay,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                '${context.watch<UserProvider>().currentMoney} kr',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const UseMoneyDialog(),
              const SizedBox(
                height: 60,
              ),
              const Divider(),
              Text(
                context.watch<DateProvider>().daysUntilSaturdayText,
              ),
              const Divider(),
              const LevelIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}

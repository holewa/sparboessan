import 'package:flutter/material.dart';
import 'package:pengastigen/providers/date_provider.dart';
import 'package:pengastigen/providers/money_provider.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:pengastigen/widgets/level_indicator.dart';
import 'package:pengastigen/widgets/log_in_dialog.dart';
import 'package:pengastigen/widgets/use_money_dialog.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.watch<UserProvider>().isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sparbössan',
            ),
            // Icon(Icons.money),
          ],
        ),
      ),
      body: isLoggedIn ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const Icon(Icons.verified_user),
                Text(
                  'Ruben',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
          Text(
            context.watch<MoneyProvider>().currentMoneyText,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const UseMoneyDialog(),
          const Divider(),
          Text(
            context.watch<DateProvider>().currentDay,
          ),
          Text(
            context.watch<DateProvider>().daysUntilSaturdayText,
          ),
          const SizedBox(
            height: 60,
          ),
          const Divider(),
          const LevelIndicator(),
          //fylla på pengar från inloggat läge annan sida
          //   FloatingActionButton(onPressed: () {
          //   context.read<MoneyProvider>().updateMoney(50);
          // })
        ],
      ): const LogInDialog(),
    );
  }
}

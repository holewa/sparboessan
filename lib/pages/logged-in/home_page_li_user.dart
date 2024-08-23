import 'package:flutter/material.dart';
import 'package:pengastigen/providers/date_provider.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:pengastigen/widgets/level_indicator.dart';
import 'package:pengastigen/widgets/use_money_dialog.dart';
import 'package:provider/provider.dart';

class HomePageLoggedInUser extends StatelessWidget {
  const HomePageLoggedInUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 417, top: 10),
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
           '${context.watch<UserProvider>().currentUserMoney} kr',
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
          //fylla på pengar från inloggat läge annan sida
          //   FloatingActionButton(onPressed: () {
          //   context.read<MoneyProvider>().updateMoney(50);
          // })
        ],
      ),
    );
  }
}

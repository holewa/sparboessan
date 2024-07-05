import 'package:flutter/material.dart';
import 'package:pengastigen/providers/date_provider.dart';
import 'package:pengastigen/providers/money_provider.dart';
import 'package:pengastigen/widgets/level_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sparbössan',
            ),
            Icon(Icons.money),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            //watch class "lyssnar" på denna variabel.
            context.watch<MoneyProvider>().currentMoneyText,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey,
              fontFamily: 'IndieFlower',
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              context.read<MoneyProvider>().useYourMoney();
            },
            label: const Text('Använd dina pengar!'),
            icon: const Icon(Icons.remove),
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Text(
            //watch class "lyssnar" på denna variabel.
            context.watch<DateProvider>().currentDay,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.blueGrey,
              fontFamily: 'IndieFlower',
            ),
          ),
          Text(
            //watch class "lyssnar" på denna variabel.
            context.watch<DateProvider>().daysUntilSaturdayText,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.blueGrey,
              fontFamily: 'IndieFlower',
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
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

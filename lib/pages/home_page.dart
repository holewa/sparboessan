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
              style: TextStyle(
                color: Colors.white70,
                fontFamily: 'IndieFamily',
                letterSpacing: 2.0,
              ),
            ),
            Icon(Icons.money),
          ],
        ),
        backgroundColor: Colors.blue,
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
          Text(
            //watch class "lyssnar" på denna variabel.
            context.watch<DateProvider>().currentDay,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey,
              fontFamily: 'IndieFlower',
            ),
          ),
          const LevelIndicator(),
          FloatingActionButton.extended(
            onPressed: () {
              context.read<MoneyProvider>().useYourMoney();
            },
            label: const Text('Använd dina pengar!'),
            icon: const Icon(Icons.remove),
          )
          //fylla på pengar från inloggat läge annan sida
          //   FloatingActionButton(onPressed: () {
          //   context.read<MoneyProvider>().updateMoney(50);
          // })
        ],
      ),
    );
  }
}

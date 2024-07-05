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
            // Icon(Icons.money),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            //watch class "lyssnar" på denna variabel.
            context.watch<MoneyProvider>().currentMoneyText,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const DialogExample(),
          const Divider(),
          Text(
            //watch class "lyssnar" på denna variabel.
            context.watch<DateProvider>().currentDay,
          ),
          Text(
            //watch class "lyssnar" på denna variabel.
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
      ),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // Show dialog and wait for a result
        String? result = await showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
            'Använda pengar..',
          ),
            content:
             Text(
            'Är du säker på att du vill använda dina pengar?',
            style: Theme.of(context).textTheme.displaySmall,
          ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Nej');
                },
                child: const Text('Nej'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Ja');
                },
                child: const Text('Ja'),
              ),
            ],
          ),
        );

        if (result == 'Ja') {
        //TODO kolla på nedanstående fel
          context.read<MoneyProvider>().useYourMoney();
        }
      },
      child: const Text('Använd dina pengar!'),
    );
  }
}

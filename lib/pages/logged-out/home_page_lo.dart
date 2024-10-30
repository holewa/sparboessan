import 'package:flutter/material.dart';
import 'package:pengastigen/providers/date_provider.dart';
import 'package:pengastigen/widgets/log_in_dialog.dart';
import 'package:provider/provider.dart';

class HomePageLoggedOut extends StatelessWidget {
  const HomePageLoggedOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 60,
          ),
          Text(
            'Välkommen till Sparbössan',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(
            height: 60,
          ),
          const Divider(),
          Text(
            'Håll koll på dina pengar!',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const Divider(),
          const LogInDialog(),
          //fylla på pengar från inloggat läge annan sida
          //   FloatingActionButton(onPressed: () {
          //   context.read<MoneyProvider>().updateMoney(50);
          // })
        ],
      ),
    );
  }
}

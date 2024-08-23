import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UseMoneyDialog extends StatelessWidget {
  const UseMoneyDialog({super.key});

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
            content: Text(
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
          context.read<UserProvider>().useMoney();
        }
      },
      child: const Text('Använd dina pengar!'),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LogInDialog extends StatelessWidget {
  const LogInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.watch<UserProvider>().isLoggedIn;

    return ElevatedButton.icon(
      label: isLoggedIn ? const Text('LoggedInUser') : const Text('Logga in') ,
      icon: isLoggedIn ? const Icon(Icons.verified_user_outlined) : const Icon(Icons.lock_person),
      iconAlignment: IconAlignment.end,
      onPressed: () async {
        // Show dialog and wait for a result
        String? result = await showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Logga in',
            ),
            content: Text(
              'Logga in?',
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
          context.read<UserProvider>().setIsLoggedIn();
        }

        if (result == 'Nej') {
          context.read<UserProvider>().setIsLoggedOut();
        }
      },
    );
  }
}

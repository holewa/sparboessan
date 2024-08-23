import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.watch<UserProvider>().isLoggedIn;

    return ElevatedButton.icon(
      label: isLoggedIn ? const Text('Logga ut') : const Text('Inte inloggad'),
      icon: isLoggedIn ? const Icon(Icons.exit_to_app) : const Icon(Icons.lock),
      iconAlignment: IconAlignment.end,
      onPressed: isLoggedIn
          ? () async {
              final bool? shouldLogOut = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return _LogOutDialogContent();
                },
              );

              if (shouldLogOut == true) {
                context.read<UserProvider>().logOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Du har loggats ut.')),
                );
              }
            }
          : null,
    );
  }
}

class _LogOutDialogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Är du säker på att du vill logga ut?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, false); // User pressed Cancel
          },
          child: const Text('Avbryt'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true); // User confirmed logout
          },
          child: const Text('Logga ut'),
        ),
      ],
    );
  }
}

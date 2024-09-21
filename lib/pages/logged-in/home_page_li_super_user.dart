import 'package:flutter/material.dart';
import 'package:pengastigen/widgets/add_money_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pengastigen/providers/user_provider.dart';

class HomePageLoggedInSuperUser extends StatelessWidget {
  const HomePageLoggedInSuperUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Superuser Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await showDialog<Map<String, dynamic>>(
              context: context,
              builder: (BuildContext context) {
                return AddMoneyDialog();
              },
            );

            if (result != null) {
              final username = result['username'];
              final amount = result['amount'];
              
              try {
                final userProvider = context.read<UserProvider>();
                userProvider.updateUserMoney(username, amount);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Money updated for $username')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            }
          },
          child: const Text('Ge någon lite flous?'),
        ),
      ),
    );
  }
}

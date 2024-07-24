import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pengastigen/pages/logged-in/home_page_li.dart';
import 'package:pengastigen/pages/logged-out/home_page_lo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.watch<UserProvider>().isLoggedIn;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sparbössan',
            ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                isLoggedIn ? const Icon(Icons.verified_user)
                : const Icon(Icons.verified_user_outlined),
                isLoggedIn ? Text(
                  context.read<UserProvider>().currentUser,
                  style: Theme.of(context).textTheme.displaySmall,
                ): const Text('Utloggat Läge'),
              ],
            ),
          ),
            // Icon(Icons.money),
          ],
        ),
      ),
      body: isLoggedIn ? const HomePageLoggedIn() : const HomePageLoggedOut(),
    );
  }
}


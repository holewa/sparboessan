import 'package:flutter/material.dart';
import 'package:pengastigen/pages/logged-in/home_page_li.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:pengastigen/widgets/log_in_dialog.dart';
import 'package:pengastigen/widgets/log_out_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pengastigen/pages/logged-out/home_page_lo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.watch<UserProvider>().isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sparbössan',
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  isLoggedIn ? const LogOutDialog() : const LogInDialog(),
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

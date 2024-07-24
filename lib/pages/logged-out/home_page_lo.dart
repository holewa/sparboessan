import 'package:flutter/material.dart';
import 'package:pengastigen/widgets/log_in_dialog.dart';

class HomePageLoggedOut extends StatelessWidget {
  const HomePageLoggedOut({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: LogInDialog(),
    );
  }
}

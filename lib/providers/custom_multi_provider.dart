import 'package:flutter/material.dart';
import 'package:pengastigen/providers/date_provider.dart';
import 'package:pengastigen/providers/money_provider.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CustomMultiProvider extends StatelessWidget {
  final Widget child;

  const CustomMultiProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoneyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DateProvider(
            Provider.of<MoneyProvider>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(), // Assuming you meant UserProvider
        ),
      ],
      child: child,
    );
  }
}

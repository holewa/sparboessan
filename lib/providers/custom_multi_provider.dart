import 'package:flutter/material.dart';
import 'package:pengastigen/providers/date_provider.dart';
import 'package:pengastigen/providers/error_message_provider.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:pengastigen/service/money_service.dart';
import 'package:pengastigen/service/user_service.dart';
import 'package:provider/provider.dart';

class CustomMultiProvider extends StatelessWidget {
  final Widget child;

  const CustomMultiProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the MoneyService and UserService first
        Provider<MoneyService>(
          create: (_) => MoneyService(),
        ),

        Provider<UserService>(
          create: (_) => UserService(),
        ),

        // Now provide UserProvider with the services above
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            Provider.of<MoneyService>(context, listen: false),
            Provider.of<UserService>(context, listen: false),
          ),
        ),
        // Provide the DateProvider instance, passing the UserProvider.
        ChangeNotifierProvider<DateProvider>(
          create: (context) => DateProvider(
            Provider.of<UserProvider>(context, listen: false),
          ),
        ),
        // Provide other providers as needed
        ChangeNotifierProvider<ErrorMessageProvider>(
          create: (context) => ErrorMessageProvider(),
        ),
      ],
      child: child,
    );
  }
}

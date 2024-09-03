import 'package:flutter/material.dart';
import 'package:pengastigen/providers/date_provider.dart';
import 'package:pengastigen/providers/error_message_provider.dart';
import 'package:pengastigen/providers/feature_toggle_provider.dart';
import 'package:pengastigen/providers/money_service.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CustomMultiProvider extends StatelessWidget {
  final Widget child;

  const CustomMultiProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the MoneyService instance.
        Provider<MoneyService>(
          create: (_) => MoneyService(),
        ),
        // Provide the UserProvider instance, passing the MoneyService.
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            Provider.of<MoneyService>(context, listen: false),
          ),
        ),
        // Provide the DateProvider instance, passing the UserProvider.
        ChangeNotifierProvider<DateProvider>(
          create: (context) => DateProvider(
            Provider.of<UserProvider>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<ErrorMessageProvider>(
          create: (context) => ErrorMessageProvider(),
        ),
        ChangeNotifierProvider<FeatureToggleProvider>(
          create: (context) => FeatureToggleProvider(),
        ),
      ],
      child: child,
    );
  }
}

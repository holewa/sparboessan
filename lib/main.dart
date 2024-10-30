import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pengastigen/constans/feature_toggles.dart';
import 'package:pengastigen/providers/custom_multi_provider.dart';
import 'package:pengastigen/pages/homepage.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return CustomMultiProvider(
      child: Builder(
        builder: (context) {
          final userProvider = context.watch<UserProvider>();

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            showSemanticsDebugger: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.purple,
                brightness:
                    userProvider.isFeatureToggled(FeatureToggles.darkMode) || userProvider.isFeatureToggled(FeatureToggles.testEnviroment) ? Brightness.dark : Brightness.light,),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.purple,
              ),
              dividerTheme: const DividerThemeData(
                thickness: 3,
                color: Colors.grey,
                space: 16,
                indent: 10,
                endIndent: 10,
              ),
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
                titleLarge: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Roboto',
                ),
                bodyMedium: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
                displaySmall: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

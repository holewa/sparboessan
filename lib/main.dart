import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pengastigen/pages/home_page.dart';
import 'package:pengastigen/providers/custom_multi_provider.dart';

void main() {
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        showSemanticsDebugger: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.dark,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
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
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
            displaySmall: TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

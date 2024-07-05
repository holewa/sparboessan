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
          primarySwatch: Colors.teal,
        ),
        home: const HomePage(),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UseMoneyDialog extends StatefulWidget {
  const UseMoneyDialog({super.key});

  @override
  _UseMoneyDialogState createState() => _UseMoneyDialogState();
}

class _UseMoneyDialogState extends State<UseMoneyDialog> {
  int selectedAmount = 0; // Default value for the slider

  @override
  Widget build(BuildContext context) {
    int currentMoney = context.read<UserProvider>().user!.currentMoney; // Hämta nuvarande pengar

    return TextButton(
      onPressed: () async {
        // Visa dialog och vänta på ett resultat
        String? result = await showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Använda pengar..'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Är du säker på att du vill använda dina pengar?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 20),
                Text('Välj belopp: \$${selectedAmount}'), // Display selected amount
                // Wrap Slider in a Container or Expanded for better usability
                Slider(
                  value: selectedAmount.toDouble(), // Convert int to double for Slider
                  min: 0,
                  max: currentMoney.toDouble(), // Convert int to double for Slide
                  divisions: currentMoney > 0 ? currentMoney : 1, // Define divisions
                  label: selectedAmount.toString(),
                  onChanged: (double value) {
                    setState(() {
                      selectedAmount = value.round(); // Use round to convert double to int
                    });
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Nej');
                },
                child: const Text('Nej'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Ja');
                },
                child: const Text('Ja'),
              ),
            ],
          ),
        );

        if (result == 'Ja') {
          // Validera och använd pengarna
          if (selectedAmount > 0) {
            context.read<UserProvider>().useMoney(selectedAmount);
          } else {
            // Visa ett felmeddelande om beloppet är ogiltigt
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Ogiltigt belopp!')),
            );
          }
        }
      },
      child: const Text('Använd dina pengar!'),
    );
  }
}

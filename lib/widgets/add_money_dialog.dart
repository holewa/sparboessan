import 'package:flutter/material.dart';

class AddMoneyDialog extends StatefulWidget {
  @override
  _AddMoneyDialogState createState() => _AddMoneyDialogState();
}

class _AddMoneyDialogState extends State<AddMoneyDialog> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onTextChanged);
    _amountController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_onTextChanged);
    _amountController.removeListener(_onTextChanged);
    _usernameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _usernameController.text.trim().isNotEmpty &&
                         _amountController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Vem ska ha pengar?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Användare',
            ),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Hur mycket?',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // User pressed Cancel
          },
          child: const Text('Avbryt'),
        ),
        TextButton(
          onPressed: _isButtonEnabled
              ? () {
                  final username = _usernameController.text.trim();
                  final amount = int.tryParse(_amountController.text.trim());

                  if (amount != null) {
                    Navigator.pop(context, {'username': username, 'amount': amount});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ogiltig summa')),
                    );
                  }
                }
              : null,
          child: const Text('Uppdatera'),
        ),
      ],
    );
  }
}

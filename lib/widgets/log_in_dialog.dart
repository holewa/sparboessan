import 'package:flutter/material.dart';
import 'package:pengastigen/models/user.dart';
import 'package:pengastigen/providers/error_message_provider.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LogInDialog extends StatelessWidget {
  const LogInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final errorProvider = context.watch<ErrorMessageProvider>();

    bool isLoggedIn = userProvider.isLoggedIn;

    return ElevatedButton.icon(
      label: isLoggedIn
          ? Text(context.watch<UserProvider>().user!.username)
          : const Text('Logga in'),
      icon: isLoggedIn
          ? const Icon(Icons.verified_user_outlined)
          : const Icon(Icons.lock_person),
      iconAlignment: IconAlignment.end,
      onPressed: () async {
        final String? username = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return _LogInDialogContent();
          },
        );

        if (username != null && username.isNotEmpty) {
          bool success = await userProvider.logIn(username);
          if (success) {
            // Display welcome message and clear errors
            final userProvider = context.read<UserProvider>();
            final username =
                userProvider.user?.username ?? 'Användaren finns inte';

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Välkommen $username!')),
            );

            context.read<ErrorMessageProvider>().clearErrorMessage();
          } else {
            errorProvider.setErrorMessage('Användaren finns inte');
          }
        } else {
          userProvider.logOut();
        }
      },
    );
  }
}

class _LogInDialogContent extends StatefulWidget {
  @override
  __LogInDialogContentState createState() => __LogInDialogContentState();
}

class __LogInDialogContentState extends State<_LogInDialogContent> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_onTextChanged);
    _usernameController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _usernameController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final errorProvider = context.watch<ErrorMessageProvider>();
    final userProvider = context.watch<UserProvider>();

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          userProvider.users.isNotEmpty
              ? Row(
                  children: userProvider.users.map((user) {
                    final bool isSelected = userProvider.selectedUser ==
                        user; // Check if this user is selected

                    return GestureDetector(
                      onTap: () {
                        // Handle user selection
                        userProvider.setSelectedUser(user);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: const NetworkImage(
                                "https://gravatar.com/avatar/213391181b5a745c816644868224e1fa?s=400&d=robohash&r=x"), // Replace with actual user image
                            radius: 40, // Adjust size as needed
                            backgroundColor: isSelected
                                ? Colors.blue
                                : Colors
                                    .transparent, // Highlight selected avatar
                            child: isSelected
                                ? const Icon(Icons.check, color: Colors.white)
                                : null, // Optional: add check mark
                          ),
                          const SizedBox(
                              height: 8), // Space between avatar and text
                          Text(
                            user, // Display username under the avatar
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight
                                      .normal, // Highlight selected username
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : const Text(""),
          if (errorProvider.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                errorProvider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: <Widget>[
        // userProvider.selectedUser != ""
        //     ? TextField(
        //         controller: _usernameController,
        //         decoration: const InputDecoration(
        //           labelText: 'Ange lösenord',
        //         ),
        //       )
        //     : const Text(""),
        TextButton(
          onPressed: () {
            errorProvider.clearErrorMessage();
            userProvider.setSelectedUser("");
            Navigator.pop(
                context, null); // User pressed Cancel or closed dialog
          },
          child: const Text('Avbryt'),
        ),
        TextButton(
          onPressed: userProvider.selectedUser != ''
              ? () async {
                  // final username = _usernameController.text.trim();
                  final username = userProvider.selectedUser;
                  bool success = await context
                      .read<UserProvider>()
                      .logIn(username);
                  if (success) {
                    Navigator.pop(context,
                        username); // Only close the dialog if login is successful
                  } else {
                    context
                        .read<ErrorMessageProvider>()
                        .setErrorMessage('Användaren finns inte');
                  }
                }
              : null, // Disable button if _isButtonEnabled is false
          child: const Text('Logga in'),
        ),
      ],
    );
  }
}

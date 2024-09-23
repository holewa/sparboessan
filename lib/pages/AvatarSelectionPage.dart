import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

class AvatarSelectionPage extends StatefulWidget {
  @override
  _AvatarSelectionPageState createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  String? selectedAvatarName;

  final List<String> userNames = [
    'Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Frank', 'Grace', 'Heidi',
    'jakob'
    // Add more names or unique identifiers
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Välj en profilbild'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: userNames.length,
        itemBuilder: (context, index) {
          final avatarName = userNames[index];
          final isSelected = selectedAvatarName == avatarName;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAvatarName = avatarName;
                userProvider.setAvatar(userNames[index]);
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40, // Adjust size as needed
                  backgroundColor:
                      isSelected ? Colors.blue : Colors.transparent,
                  foregroundColor:
                      Colors.transparent, // Highlight selected avatar
                  child: ClipOval(
                    child: RandomAvatar(
                      userNames[index],
                      // user, // Replace with actual user or unique string to generate avatars
                      height: 80, // Adjust avatar height
                      width: 80, // Adjust avatar width
                      trBackground: true,
                    ),
                  ),
                ),
                // Text(
                //   avatarName,
                //   style: const TextStyle(fontSize: 14),
                // ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedAvatarName != null) {
            Navigator.pop(context, selectedAvatarName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Välj en profilbild')),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

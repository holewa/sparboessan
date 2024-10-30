// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pengastigen/constans/endpoint_constants.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:pengastigen/service/user_service.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:http/http.dart' as http;

class AvatarSelectionPage extends StatefulWidget {
  const AvatarSelectionPage({super.key});

  @override
  _AvatarSelectionPageState createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  String? selectedAvatarName;
  List<String> userNames = [];
  late UserService userService;
  String localHost = EndpointConstants.LOCALHOST;

  final List<String> userNamesOld = [
    'hej', 'Bob', 'Charlie', 'David', 'Eve', 'Frank', 'Grace', 'Heidi',
    'jakob', 'niklas', 'oscar', 'josef', 'william', 'hwhd', 'hdhsd', 'Ruben',
    'Joel', 'mamma', 'pappa,' 'otto', 'parpa'
    // TODO: paginate
  ];

  @override
  void initState() {
    super.initState();
    userNames = List.generate(20, (_) => generateRandomString(10));
  }

  String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

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
          crossAxisCount: 5,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: userNames.length,
        itemBuilder: (context, index) {
          final avatarName = userNames[index];
          final isSelected = selectedAvatarName == avatarName;

          return GestureDetector(
            onTap: () {
              selectedAvatarName = avatarName;
              userProvider.setAvatar(userNames[index]);
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
        onPressed: () async {
          if (selectedAvatarName != null) {
            Navigator.pop(context, selectedAvatarName);
            var url = Uri.parse(
                '${userService.localHost}/users/${userProvider.user?.id.toString()}');
            await http.put(
              url,
              body: jsonEncode({'avatar': selectedAvatarName}),
              headers: {"Content-Type": "application/json"},
            );
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

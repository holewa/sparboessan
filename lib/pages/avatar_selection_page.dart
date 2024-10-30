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
  String? selectedAvatar;
  List<String> userNames = [];
  late UserService userService;
  String localHost = EndpointConstants.LOCALHOST;

  int currentPage = 0;
  final int itemsPerPage = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadAvatars();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userService = Provider.of<UserService>(context);
  }

  Future<void> loadAvatars() async {
    if (isLoading) return; // Prevent multiple loads
    setState(() {
      isLoading = true; // Start loading
    });

    // Simulate an API call with a delay
    await Future.delayed(const Duration(seconds: 1));

    // Fetch avatars based on current page
    List<String> newAvatars = await fetchAvatars(currentPage, itemsPerPage);
    
    setState(() {
      userNames = newAvatars; // Replace current avatars with new ones
      isLoading = false; // Stop loading
    });
  }

  Future<List<String>> fetchAvatars(int page, int itemsPerPage) async {
    // Simulate fetching avatars (for demo purposes)
    return List.generate(itemsPerPage, (_) => generateRandomString(10));
  }

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  void nextPage() {
    setState(() {
      currentPage++;
    });
    loadAvatars();
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      loadAvatars();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Välj en profilbild'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: userNames.length,
              itemBuilder: (context, index) {
                final avatarName = userNames[index];
                final isSelected = selectedAvatar == avatarName;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatarName;
                      userProvider.setAvatar(userNames[index]);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: isSelected ? Colors.blue : Colors.transparent,
                        child: ClipOval(
                          child: RandomAvatar(
                            userNames[index],
                            height: 80,
                            width: 80,
                            trBackground: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (isLoading) const CircularProgressIndicator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: previousPage,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: nextPage,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (selectedAvatar != null) {
            Navigator.pop(context, selectedAvatar);
            userService.changeAvatar(userProvider.user?.id.toString(), selectedAvatar!);
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

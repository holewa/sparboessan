import 'package:flutter/material.dart';
import 'package:pengastigen/pages/logged-in/home_page_li.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:pengastigen/widgets/hamburger_menu.dart';
import 'package:pengastigen/widgets/log_in_dialog.dart';
import 'package:pengastigen/widgets/log_out_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pengastigen/pages/logged-out/home_page_lo.dart';
import 'package:random_avatar/random_avatar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    bool isLoggedIn = userProvider.isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 40, // Adjust size as needed
              backgroundColor:
                  // isSelected ? Colors.blue : Colors.transparent,
                  Colors.transparent,
              foregroundColor: Colors.transparent, // Highlight selected avatar
              child: ClipOval(
                child: isLoggedIn ? RandomAvatar(
                  userProvider.user?.avatar ?? '', 
                  // userNames[index],
                  // user, // Replace with actual user or unique string to generate avatars
                  height: 50, // Adjust avatar height
                  width: 50, // Adjust avatar width
                  trBackground: true,
                ): null,
              ),
            ),
            isLoggedIn ? const LogOutDialog() : const LogInDialog(),
          ],
        ),
      ),
      drawer: isLoggedIn ? const HamburgerMenu() : null,
      body: isLoggedIn ? const HomePageLoggedIn() : const HomePageLoggedOut(),
    );
  }
}

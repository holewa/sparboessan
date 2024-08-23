import 'package:flutter/material.dart';
import 'package:pengastigen/pages/logged-in/home_page_li_super_user.dart';
import 'package:pengastigen/pages/logged-in/home_page_li_user.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePageLoggedIn extends StatelessWidget {
  const HomePageLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSuperUser = context.watch<UserProvider>().isSuperUser;

    return isSuperUser
        ? const HomePageLoggedInSuperUser()
        : const HomePageLoggedInUser();
  }
}

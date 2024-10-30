import 'package:flutter/material.dart';
import 'package:pengastigen/constans/app_colors.dart';
import 'package:pengastigen/constans/feature_toggles.dart';
import 'package:pengastigen/pages/avatar_selection_page.dart';
import 'package:pengastigen/widgets/feature_toggle_button.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.otherColor,
            ),
            child: Text('Inställningar'),
          ),
          const ListTile(
            title: Text('Testmiljö'),
            leading: FeatureToggleButton(
                featureKey: FeatureToggles.testEnviroment),
          ),
          const ListTile(
            leading:
                FeatureToggleButton(featureKey: FeatureToggles.darkMode),
            title: Text('Dark mode'),
          ),
          ListTile(
            leading: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvatarSelectionPage(),
                  ),
                );
              },
              child: const Text('Byt profilbild'),
            ),
          ),
        ],
      ),
    );
  }

}

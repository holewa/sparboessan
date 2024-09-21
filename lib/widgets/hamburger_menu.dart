import 'package:flutter/material.dart';
import 'package:pengastigen/constans/app_colors.dart';
import 'package:pengastigen/constans/feature_toggles.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:pengastigen/widgets/feature_toggle_button.dart';
import 'package:provider/provider.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    // final featureToggleProvider = context.watch<FeatureToggleProvider>();

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
          ListTile(
            title: const Text('Testmiljö'),
            leading: const FeatureToggleButton(
                featureKey: FeatureToggles.testEnviroment),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading:
                const FeatureToggleButton(featureKey: FeatureToggles.darkMode),
            title: const Text('Dark mode'),
            onTap: () {
              userProvider.setFeatureToggle(FeatureToggles.darkMode);

              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}

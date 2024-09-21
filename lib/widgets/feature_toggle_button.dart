import 'package:flutter/material.dart';
import 'package:pengastigen/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FeatureToggleButton extends StatelessWidget {
  final String featureKey;
  // final isToggled =  userProvider.isFeatureToggled(featureKey);

  const FeatureToggleButton({super.key, required this.featureKey});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Switch(
      activeColor: Colors.amber,
      activeTrackColor: Colors.cyan,
      inactiveThumbColor: Colors.blueGrey.shade600,
      inactiveTrackColor: Colors.grey.shade400,
      splashRadius: 35.0,
      value: userProvider.isFeatureToggled(featureKey),
      onChanged: (value) => userProvider.setFeatureToggle(featureKey),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pengastigen/providers/feature_toggle_provider.dart';
import 'package:provider/provider.dart';

class FeatureToggleButton extends StatelessWidget {
  final String featureKey;

  const FeatureToggleButton({super.key, required this.featureKey});

  @override
  Widget build(BuildContext context) {
    final featureToggleProvider = context.watch<FeatureToggleProvider>();
    final isToggled = featureToggleProvider.isFeatureToggled(featureKey);

    return Switch(
      activeColor: Colors.amber,
      activeTrackColor: Colors.cyan,
      inactiveThumbColor: Colors.blueGrey.shade600,
      inactiveTrackColor: Colors.grey.shade400,
      splashRadius: 35.0,
      value: isToggled,
      onChanged: (value) => featureToggleProvider.setFeatureToggled(featureKey, value),
    );
  }
}

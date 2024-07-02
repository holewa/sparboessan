import 'package:flutter/material.dart';
import 'package:pengastigen/widgets/develop/is_developing.dart';

class WidgetWrapper extends StatelessWidget {
  final Widget child;
  final bool showBackground;

  const WidgetWrapper({
    super.key,
    required this.child,
    this.showBackground = IsDeveloping.isDeveloping,
  });

  @override
  Widget build(BuildContext context) {
    return showBackground
        ? Container(
            color: Colors.blue
                .withOpacity(0.2), // Example background color with opacity
            padding:
                const EdgeInsets.all(8.0), // Optional: Adjust padding as needed
            child: child,
          )
        : child;
  }
}

import 'package:flutter/material.dart';

class CoinAnimation extends StatefulWidget {
  final VoidCallback onComplete;

  const CoinAnimation({required this.onComplete, super.key});

  @override
  _CoinAnimationState createState() => _CoinAnimationState();
}

class _CoinAnimationState extends State<CoinAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: _animation.value * MediaQuery.of(context).size.height,
          left: MediaQuery.of(context).size.width / 2 - 25,
          child: child!,
        );
      },
      child: Image.asset(
        'assets/images/coiny.png',
        width: 40,
        height: 40,
      ),
    );
  }
}

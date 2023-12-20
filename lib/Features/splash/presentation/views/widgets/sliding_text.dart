import 'package:flutter/cupertino.dart';
import 'package:pteye/core/utils/style.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) => SlideTransition(
        position: slidingAnimation,
        child: const Text(
          'Welcome to PT eye',style: Styles.textStyle16,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

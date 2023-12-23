import 'package:flutter/material.dart';
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
        child:  Text(
          'تدرب جيداً لصحة أفضل',style: Styles.textStyle16.copyWith(color: Colors.white,fontWeight: FontWeight.w600 ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

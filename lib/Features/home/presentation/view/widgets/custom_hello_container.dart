import 'package:flutter/material.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/generated/assets.dart';

class HelloContainer extends StatelessWidget {
  const HelloContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.all(16),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(Assets.imagesHealthy),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'أهلاً بك محمد',
                style: Styles.textStyle18.copyWith(color: Colors.white),
              ),
              Text(
                'تدرب جيداً لصحة أفضل',
                style: Styles.textStyle16.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/generated/assets.dart';

class CustomExerciseGridViewItem extends StatelessWidget {
  const CustomExerciseGridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1,),
            AspectRatio(
              aspectRatio: 5,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(Assets.imagesHealthy),)
                ),
              ),
            ),
            // Image.asset(Assets.imagesItem,),
            //Icon(Icons.medical_services_rounded,color: kPrimaryColor,size: 120,),
            const SizedBox(
              height: 2,
            ),
            const Text('اسم التمرين',style: Styles.textStyle18,),
            const Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}

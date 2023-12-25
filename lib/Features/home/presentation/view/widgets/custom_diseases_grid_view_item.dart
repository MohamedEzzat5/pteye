import 'package:flutter/material.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/generated/assets.dart';

class CustomGridViewItem extends StatelessWidget {
  const CustomGridViewItem({super.key});

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
              aspectRatio: 2/1.5,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(Assets.imagesItem),fit: BoxFit.fill,)
                ),
              ),
            ),
            // Image.asset(Assets.imagesItem,),
            //Icon(Icons.medical_services_rounded,color: kPrimaryColor,size: 120,),
            const SizedBox(
              height: 2,
            ),
            const Text('اسم المرض',style: Styles.textStyle18,),
            const Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}

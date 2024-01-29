import 'package:flutter/material.dart';
import 'package:pteye/core/utils/media_query_values.dart';
import 'package:pteye/core/utils/style.dart';

class CustomExerciseListViewItem extends StatelessWidget {
  const CustomExerciseListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
      },
      child: Container(
        height: context.height*0.25,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1,),
            Icon(Icons.play_circle,size: context.height*0.16,),
            SizedBox(height: context.height*0.015,),
             Text('اسم التمرين',style: Styles.textStyle20.copyWith(color: Colors.white),),
            const Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}

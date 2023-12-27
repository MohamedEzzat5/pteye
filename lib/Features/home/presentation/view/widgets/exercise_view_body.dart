
import 'package:flutter/material.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_diseases_grid_view_item.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_exercise_grid_view_item.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';

class ExerciseViewBody extends StatelessWidget {
  const ExerciseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

    Expanded(
    child: GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,mainAxisSpacing: 15,crossAxisSpacing: 15,childAspectRatio: 2),
    itemCount: 6,
    physics: const  BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    itemBuilder: (context, index){
    return const CustomExerciseGridViewItem();
    },
    ),
    ),
      ],
    );
  }
}

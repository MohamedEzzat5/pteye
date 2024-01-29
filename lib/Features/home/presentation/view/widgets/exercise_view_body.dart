import 'package:flutter/material.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_exercise_list_view_item.dart';
import 'package:pteye/core/component/animation/list_animator_data.dart';
import 'package:pteye/core/utils/media_query_values.dart';

class ExerciseViewBody extends StatelessWidget {
  const ExerciseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListAnimatorData(
      padding: EdgeInsets.symmetric(
          vertical: context.height * 0.02, horizontal: context.width * 0.04),
      isAnimated: true,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 5,
      separatorWidget: SizedBox(
        height: context.height * 0.02,
      ),
      itemBuilder: (context, index) {
        return const CustomExerciseListViewItem();
      },
    );
  }
}

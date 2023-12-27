import 'package:flutter/material.dart';
import 'package:pteye/Features/home/presentation/view/widgets/exercise_view_body.dart';

import '../../../../core/utils/constance.dart';
import '../../../../core/utils/style.dart';

class ExerciseView extends StatelessWidget {
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التمارين',
          style: Styles.textStyle22.copyWith(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: const ExerciseViewBody(),
    );
  }
}

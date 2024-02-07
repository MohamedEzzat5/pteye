import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pteye/Features/home/presentation/manger/exercise_cubit/exercise_cubit.dart';
import 'package:pteye/Features/home/presentation/manger/exercise_cubit/exercise_state.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_exercise_grid_view.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';

class ExerciseView extends StatelessWidget {
  final String diseaseName;

  const ExerciseView({Key? key, required this.diseaseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: Text('$diseaseName - تمارين', style: Styles.textStyle20.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ExerciseCubit(),
        child: BlocBuilder<ExerciseCubit, ExerciseState>(
          builder: (context, state) {
            if (state is ExerciseInitial) {
              context.read<ExerciseCubit>().fetchExerciseVideos(diseaseName);
              return  const Center(child: SpinKitFadingCircle(color: kPrimaryColor,));
            } else if (state is ExerciseLoaded) {
              return CustomExerciseGridView(exerciseVideos: state.exerciseVideos);
            } else if (state is ExerciseError) {
              return const Center(child: Text('قم بالتأكد من الاتصال بالانترنت'));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

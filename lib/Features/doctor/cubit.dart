import 'package:bloc/bloc.dart';

class SelectedExercisesCubit extends Cubit<Set<String>> {
  SelectedExercisesCubit() : super({});

  void toggleExercise(String exerciseName, bool isSelected) {
    final updatedExercises = Set<String>.from(state);
    if (isSelected) {
      updatedExercises.remove(exerciseName);
    } else {
      updatedExercises.add(exerciseName);
    }
    emit(updatedExercises);
  }

  void clearSelectedExercises() {
    emit({});
  }
}


class IsDoneCubit extends Cubit<bool> {
  IsDoneCubit() : super(false);

  void setIsDone(bool value) => emit(value);
}
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());

  void fetchExerciseVideos(String diseaseName) async {
    emit(ExerciseInitial());

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('diseases')
          .where('name', isEqualTo: diseaseName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> diseaseData = querySnapshot.docs.first.data();
        List<Map<String, dynamic>> videos = List<Map<String, dynamic>>.from(diseaseData['videos']);

        emit(ExerciseLoaded(exerciseVideos: videos));
      } else {
        emit(ExerciseLoaded(exerciseVideos: const []));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching exercise videos: $e');
      }
      emit(ExerciseError(error: 'Error fetching exercise videos: $e'));
    }
  }
}
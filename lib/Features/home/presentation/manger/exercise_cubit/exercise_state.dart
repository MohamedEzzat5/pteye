import 'package:equatable/equatable.dart';
abstract class ExerciseEvent extends Equatable {}
class FetchExerciseVideos extends ExerciseEvent {
  final String diseaseName;

  FetchExerciseVideos({required this.diseaseName});
  @override
  List<Object?> get props => [diseaseName];
}

// States
abstract class ExerciseState extends Equatable {}

class ExerciseInitial extends ExerciseState {
  @override
  List<Object?> get props => [];
}

class ExerciseLoaded extends ExerciseState {
  final List<Map<String, dynamic>> exerciseVideos;

  ExerciseLoaded({required this.exerciseVideos});

  @override
  List<Object?> get props => [exerciseVideos];
}

class ExerciseError extends ExerciseState {
  final String error;

  ExerciseError({required this.error});

  @override
  List<Object?> get props => [error];
}

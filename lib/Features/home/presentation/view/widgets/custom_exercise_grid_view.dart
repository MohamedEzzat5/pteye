import 'package:flutter/material.dart';

import 'custom_exercise_list_view_item.dart';

class CustomExerciseGridView extends StatelessWidget {
  const CustomExerciseGridView({
    super.key,
    required this.exerciseVideos,
  });

  final List<Map<String, dynamic>> exerciseVideos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: exerciseVideos.length,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemBuilder: (context, index) {
        return CustomExerciseGridViewItem(
          exerciseName: exerciseVideos[index]['exerciseName'] ?? '',
          videoLink: exerciseVideos[index]['link'] ?? '',
        );
      },
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pteye/Features/doctor/cubit.dart';
import '../../../../core/utils/constance.dart';
import '../../../../core/widgets/default_text.dart';

class AdminVideoScreen extends StatelessWidget {
  const AdminVideoScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectedExercisesCubit(),
      child: _AdminVideoScreenContent(userId: userId),
    );
  }
}

class _AdminVideoScreenContent extends StatelessWidget {
  final String userId;

  const _AdminVideoScreenContent({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: Text(userId),
        actions: [
          BlocBuilder<SelectedExercisesCubit, Set<String>>(
            builder: (context, selectedExercises) {
              if (selectedExercises.isNotEmpty) {
                return IconButton(
                  onPressed: () {
                    // Handle saving selected items
                    if (kDebugMode) {
                      print('Selected Exercises: $selectedExercises');
                    }
                    // Clear selected items
                    context
                        .read<SelectedExercisesCubit>()
                        .clearSelectedExercises();
                  },
                  icon: const Icon(Icons.check),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('diseases').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFadingCircle(
                color: kPrimaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final docs = snapshot.data!.docs;
            final List<String> exerciseNames = [];
            //final List<String> exerciseLink =[];

            for (final doc in docs) {
              final videos = doc['videos'] as List<dynamic>;
              for (final video in videos) {
                exerciseNames.add(video['exerciseName']);
                // exerciseLink.add(video['link']);
              }
            }

            return GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 8 / 7,
              ),
              itemCount: exerciseNames.length,
              itemBuilder: (context, index) {
                final exerciseName = exerciseNames[index];
                return GestureDetector(
                  onTap: () {
                    final isSelected = context
                        .read<SelectedExercisesCubit>()
                        .state
                        .contains(exerciseName);
                    context
                        .read<SelectedExercisesCubit>()
                        .toggleExercise(exerciseName, isSelected);
                  },
                  child: BlocBuilder<SelectedExercisesCubit, Set<String>>(
                    builder: (context, selectedExercises) {
                      final isSelected =
                          selectedExercises.contains(exerciseName);
                      return Card(
                        elevation: 3,
                        color: isSelected ? Colors.blue.withOpacity(0.5) : null,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: DefaultText(
                              text: exerciseName,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              maxLines: 4,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

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

class _AdminVideoScreenContent extends StatefulWidget {
  final String userId;

  const _AdminVideoScreenContent({Key? key, required this.userId})
      : super(key: key);

  @override
  State<_AdminVideoScreenContent> createState() =>
      _AdminVideoScreenContentState();
}

class _AdminVideoScreenContentState extends State<_AdminVideoScreenContent> {
  late Future<List<Map<String, String>>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = fetchExercises();
  }

  Future<List<Map<String, String>>> fetchExercises() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('diseases').get();
      final List<Map<String, String>> fetchedExercises = [];

      for (final doc in snapshot.docs) {
        final videos = doc['videos'] as List<dynamic>;
        for (final video in videos) {
          final diseasesName = doc['name'] as String;
          final exerciseName = video['exerciseName'] as String;
          final link = video['link'] as String;
          final exercise = {
            'diseasesName': diseasesName,
            'exerciseName': exerciseName,
            'link': link,
          };
          fetchedExercises.add(exercise);
        }
      }

      return fetchedExercises;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching exercises: $error');
      }
      rethrow; // Propagate error to FutureBuilder
    }
  }

  // Function to store selected items in Firestore
  Future<void> _storeSelectedItems(
      String userId, List<Map<String, String>> selectedItems) async {
    try {
      // Reference to the "selected_items" collection
      final DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('selected_items').doc(userId);

      // Store selected items under the user's document
      await userDocRef.set({
        'isDone':false,
        'selectedItems': selectedItems,
      });

      // Optional: You can add a confirmation message here if needed
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          showCloseIcon: true,
          content: DefaultText(
            text: 'تم اضافة التمارين بنجاح',
            color: Colors.white,
            fontSize: 14,
            textAlign: TextAlign.right,
          )));
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error storing selected items: $error');
      }
    }
  }

  // Function to delete stored data for a user
  Future<void> _deleteStoredData(String userId) async {
    try {
      // Reference to the user's document in the "selected_items" collection
      final DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('selected_items').doc(userId);

      // Delete the document
      await userDocRef.delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          showCloseIcon: true,
          content: DefaultText(
            text: 'تم ازالة التمارين بنجاح',
            color: Colors.white,
            fontSize: 14,
            textAlign: TextAlign.right,
          )));

      // Optional: You can add a confirmation message here if needed
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error deleting stored data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: _exercisesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                color: kPrimaryColor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                color: kPrimaryColor,
              ),
            ),
          );
        } else {
          final List<Map<String, String>> exercises = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: kPrimaryColor),
              title: Text(widget.userId),
              actions: [
                IconButton(
                  onPressed: () {
                    _deleteStoredData(widget.userId);
                  },
                  icon: const Icon(Icons.delete),
                ),
                BlocBuilder<SelectedExercisesCubit, Set<String>>(
                  builder: (context, selectedExercises) {
                    if (selectedExercises.isNotEmpty) {
                      return IconButton(
                        onPressed: () {
                          // Handle saving selected items
                          if (kDebugMode) {
                            print('Selected Exercises: $selectedExercises');
                          }

                          // Retrieve selected items from state
                          final selectedItems =
                              selectedExercises.map((exerciseName) {
                            // Find the exercise by name and retrieve its link from the original exercises list
                            final selectedExercise = exercises.firstWhere(
                                (exercise) =>
                                    exercise['exerciseName'] == exerciseName);
                            return selectedExercise;
                          }).toList();

                          // Store selected items in Firestore under the user's document
                          _storeSelectedItems(widget.userId, selectedItems);

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
            body: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                final exerciseName = exercise['exerciseName'];
                final diseasesName = exercise['diseasesName'];

                return GestureDetector(
                  onTap: () {
                    final isSelected = context
                        .read<SelectedExercisesCubit>()
                        .state
                        .contains(exerciseName);
                    context
                        .read<SelectedExercisesCubit>()
                        .toggleExercise(exerciseName!, isSelected);
                  },
                  child: BlocBuilder<SelectedExercisesCubit, Set<String>>(
                    builder: (context, selectedExercises) {
                      final isSelected =
                          selectedExercises.contains(exerciseName);
                      return Card(
                        elevation: 3,
                        color: isSelected ? Colors.blue.withOpacity(0.5) : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultText(
                                text: diseasesName!.toString(),
                                fontSize: 12,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              DefaultText(
                                text: exerciseName!,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

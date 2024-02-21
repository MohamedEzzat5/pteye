import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/utils/constance.dart';
import '../../../../core/widgets/default_text.dart';
class AdminVideoScreen extends StatefulWidget {
  const AdminVideoScreen({Key? key}) : super(key: key);

  @override
  _AdminVideoScreenState createState() => _AdminVideoScreenState();
}

class _AdminVideoScreenState extends State<AdminVideoScreen> {
  final Set<String> _selectedExercises = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text('Exercises'),
        actions: [
          if (_selectedExercises.isNotEmpty)
            IconButton(
              onPressed: () {
                // Handle saving selected items
                if (kDebugMode) {
                  print('Selected Exercises: $_selectedExercises');
                }
                // Clear selected items
                setState(() {
                  _selectedExercises.clear();
                });
              },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('diseases').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFadingCircle(color: kPrimaryColor,),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final docs = snapshot.data!.docs;
            final List<String> exerciseNames = [];

            for (final doc in docs) {
              final videos = doc['videos'] as List<dynamic>;
              for (final video in videos) {
                exerciseNames.add(video['exerciseName']);
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
                final isSelected = _selectedExercises.contains(exerciseName);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedExercises.remove(exerciseName);
                      } else {
                        _selectedExercises.add(exerciseName);
                      }
                    });
                  },
                  child: Card(
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

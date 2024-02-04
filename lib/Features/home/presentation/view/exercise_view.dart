import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_exercise_grid_view.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: Text('$diseaseName- تمارين ',style: Styles.textStyle20.copyWith(color: kPrimaryColor,fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ExerciseService.getExerciseVideosForDisease(diseaseName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            List<Map<String, dynamic>> exerciseVideos = snapshot.data ?? [];

            return CustomExerciseGridView(exerciseVideos: exerciseVideos);
          } else {
            return  const Center(
              child: SpinKitFadingCircle(color: kPrimaryColor,),
            );
          }
        },
      ),
    );
  }
}




class ExerciseService {
  static Future<List<Map<String, dynamic>>> getExerciseVideosForDisease(String diseaseName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('diseases')
          .where('name', isEqualTo: diseaseName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming only one document matches the diseaseName
        Map<String, dynamic> diseaseData = querySnapshot.docs.first.data();

        // Extract the 'videos' field from the document
        List<Map<String, dynamic>> videos = List<Map<String, dynamic>>.from(diseaseData['videos']);

        return videos;
      } else {
        // Handle the case when no matching disease is found
        return [];
      }
    } catch (e) {
      // Handle exceptions, e.g., Firestore errors
      if (kDebugMode) {
        print('Error fetching exercise videos: $e');
      }
      return [];
    }
  }
}

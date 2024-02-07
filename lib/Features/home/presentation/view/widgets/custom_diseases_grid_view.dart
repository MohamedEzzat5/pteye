import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_diseases_grid_view_item.dart';
import 'package:pteye/core/utils/constance.dart';

class CustomDiseasesGridView extends StatelessWidget {
  const CustomDiseasesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: DiseaseService.getDiseases(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final diseases = snapshot.data;

          return Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemCount: diseases?.length ?? 0,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) {
                final disease = diseases![index];
                return CustomGridViewItem(
                  diseaseName: disease['name']!,
                  imageUrl: disease['imageUrl']!,
                );
              },
            ),
          );
        } else {
          return const Center(child: SpinKitFadingCircle(color: kPrimaryColor,));
        }
      },
    );
  }
}
class DiseaseService {
  static Future<List<Map<String, String>>> getDiseases() async {
    final snapshot = await FirebaseFirestore.instance.collection('diseases').get();

    return snapshot.docs
        .map((doc) => {
      'name': doc['name'] as String,
      'imageUrl': doc['imageUrl'] as String,
    })
        .toList();
  }
}
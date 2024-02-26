import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/media_query_values.dart';
import 'package:pteye/core/utils/style.dart';

class FilesView extends StatelessWidget {
  const FilesView({super.key,});

  @override
  Widget build(BuildContext context) {
    navigateToLogin() {
      GoRouter.of(context).push(AppRouter.kLoginView);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              navigateToLogin();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('selected_items').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final document = snapshot.data!.docs[index];
                final String userFileId = document.id;
                final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                if (userFileId == currentUserId) {
                  return const SizedBox();
                }
                return GestureDetector(
                  onTap: () {
                   // GoRouter.of(context).push(AppRouter.kDoctorVideoView,extra: userId);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    height: context.height * 0.14,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ' +
                            snapshot.data!.docs[index]['selectedItems']['exerciseName'].toString(),
                            style: Styles.textStyle16.copyWith(
                                color: Colors.white)),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const SpinKitFadingCircle(
              color: kPrimaryColor,
            );
          }
        },
      ),
    );
  }
}

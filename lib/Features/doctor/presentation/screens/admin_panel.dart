import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/media_query_values.dart';
import 'package:pteye/core/utils/style.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key,});

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
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final int displayIndex = index + 1;
                final document = snapshot.data!.docs[index];
                final String userId = document.id;
                if (userId == doctorId) {
                  return const SizedBox();
                }
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kDoctorVideoView,);
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
                        Text(
                          'Patient: ' + displayIndex.toString(),
                          style: Styles.textStyle16.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text('Name: ' +
                            snapshot.data!.docs[index]['username'],
                            style: Styles.textStyle16.copyWith(
                                color: Colors.white)),
                        Text('Email: ' +
                            snapshot.data!.docs[index]['email'],
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

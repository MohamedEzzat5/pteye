// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/media_query_values.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/utils/widgets/alert_dialog.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      bool type = false;
      await Future.delayed(
        Duration.zero,
        () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  'هل تريد الخروج من البرنامج؟',
                  style:
                      Styles.textStyle20.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.end,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        type = false;
                        Navigator.pop(context);
                      },
                      child: const Text('لا', style: Styles.textStyle16)),
                  TextButton(
                      onPressed: () {
                        type = true;
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'نعم',
                        style: Styles.textStyle16,
                      )),
                ],
              );
            },
          );
        },
      );
      return type;
    }

    navigateToLogin() {
      GoRouter.of(context).push(AppRouter.kLoginView);
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                    onLongPress: () {
                      customAwesomeDialog(
                        title: 'حذف الحساب',
                        description: 'هل تريد تريد حذف هذا الحساب؟',
                        dialogType: DialogType.question,
                        buildContext: context,
                        okOnPressed: () async {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .delete();
                        },
                      );
                    },
                    onTap: () {
                      GoRouter.of(context)
                          .push(AppRouter.kDoctorVideoView, extra: userId);
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
                          Text(
                              'Name: ' + snapshot.data!.docs[index]['username'],
                              style: Styles.textStyle16
                                  .copyWith(color: Colors.white)),
                          Text('Email: ' + snapshot.data!.docs[index]['email'],
                              style: Styles.textStyle16
                                  .copyWith(color: Colors.white)),
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
      ),
    );
  }
}

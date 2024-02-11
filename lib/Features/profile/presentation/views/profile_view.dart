import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pteye/Features/profile/presentation/views/widgets/custom_Container.dart';
import 'package:pteye/Features/profile/presentation/views/widgets/custom_align_text.dart';
import 'package:pteye/Features/profile/presentation/views/widgets/custom_avatar.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';
import 'package:pteye/core/widgets/default_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key,});

  @override
  Widget build(BuildContext context) {
    navigateToLogin(){
      GoRouter.of(context).push(AppRouter.kLoginView);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(appBarTitle: 'الملف الشخصي'),
            const SizedBox(height: 15),
            const CustomAvatar(),
            const SizedBox(height: 5),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var userData = snapshot.data?.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        style: Styles.textStyle16,
                      ),
                      const SizedBox(height: 15),
                      const CustomAlignText(text: 'الاسم'),
                      const SizedBox(height: 5),
                      CustomContainer(
                        text: userData['username'].toString(),
                      ),
                      userData['phoneNumber'] == "" ? const SizedBox() :
                      Column(
                        children: [
                          const SizedBox(height: 15),
                          const CustomAlignText(text: 'رقم الهاتف'),
                          const SizedBox(height: 5),
                          CustomContainer(
                            text: userData['phoneNumber'].toString() ,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomMaterialButton(
                          background: Colors.red,
                          onPressed: () async {
                            GoogleSignIn googleSignIn = GoogleSignIn();
                            googleSignIn.disconnect();
                            await FirebaseAuth.instance.signOut();
                            navigateToLogin();
                          },
                          text: 'تسجيل الخروج',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                } else {
                  return  const SpinKitFadingCircle(color: kPrimaryColor,);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

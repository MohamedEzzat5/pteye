import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pteye/Features/profile/presentation/views/widgets/custom_Container.dart';
import 'package:pteye/Features/profile/presentation/views/widgets/custom_align_text.dart';
import 'package:pteye/Features/profile/presentation/views/widgets/custom_avatar.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';
import 'package:pteye/core/widgets/default_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(appBarTitle: 'الملف الشخصي'),
          const SizedBox(
            height: 15,
          ),
          const CustomAvatar(),
          const SizedBox(
            height: 5,
          ),
           Text(
            FirebaseAuth.instance.currentUser!.email.toString(),
            style: Styles.textStyle16,
          ),
          const SizedBox(
            height: 40,
          ),
          CustomAlignText(text: 'الاسم'),
          const SizedBox(
            height: 5,
          ),
          CustomContainer(
            text: FirebaseAuth.instance.currentUser!.displayName.toString(),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomAlignText(text: 'رقم الهاتف'),
          const SizedBox(
            height: 5,
          ),
          CustomContainer(
            text: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomMaterialButton(
              background: Colors.red,
                onPressed: ()async
                {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  GoRouter.of(context).push(AppRouter.kLoginView);
                },
                text: 'تسجيل الخروج',fontSize: 18,fontWeight: FontWeight.w600,)
          )
        ],
      ),
    );


  }

}
